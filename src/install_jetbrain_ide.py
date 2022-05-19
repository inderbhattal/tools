import os
import shutil
import tarfile

from utils import get_logger

logger = get_logger()

root_dir = "/mnt/SSD-1"
ide_root_dir = f"{root_dir}/ide"
ide_config_root_dir = f"{root_dir}/ide_config"

idea_properties_file_names = {
    "clion": f"{ide_config_root_dir}/.CLion",
    "datagrip": f"{ide_config_root_dir}/.DataGrip",
    "goland": f"{ide_config_root_dir}/.GoLand",
    "idea-iu": f"{ide_config_root_dir}/.IntelliJIdea",
    "pycharm": f"{ide_config_root_dir}/.Pycharm",
    "webstorm": f"{ide_config_root_dir}/.Webstorm",
}

idea_log_path = "idea.log.path="
idea_config_path = "idea.config.path="
idea_system_path = "idea.system.path="
idea_plugins_path = "idea.plugins.path="

ide_names_config_folder_name = {
    "clion": ".CLion",
    "goland": ".GoLand",
    "pycharm": ".PyCharm",
    "webstorm": ".WebStorm",
    "datagrip": ".DataGrip",
    "idea-iu": ".IntelliJIdea",
}


def get_ide_tar_paths():
    file_paths = []

    for file_name in os.listdir(root_dir):
        if file_name.endswith(".tar.gz"):
            new_file_name = file_name.lower()
            old_file_path = os.path.join(root_dir, file_name)
            new_file_path = os.path.join(root_dir, new_file_name)

            os.rename(old_file_path, new_file_path)
            file_paths.append(new_file_path)

    file_paths = sorted(file_paths)
    logger.info(f"{file_paths}")

    return file_paths


def get_ide_folders():
    ide_folders_paths = {}

    for ide_folder_name in os.listdir(ide_root_dir):
        ide_folder_path = os.path.join(ide_root_dir, ide_folder_name)
        ide_folders_paths[ide_folder_name] = ide_folder_path

    return ide_folders_paths


def clean_ide_install_files(ide_tar_file_paths):
    for ide_tar_file_path in ide_tar_file_paths:
        logger.info(f"Deleting file: {ide_tar_file_path}")

        os.remove(ide_tar_file_path)


def amend_ide_config_file(ide_properties_file_path, ide_name):
    logger.info(f"Creating backup of properties file: {ide_properties_file_path}")

    ide_properties_file_path_bckup = f"{ide_properties_file_path}.ori"
    shutil.copyfile(ide_properties_file_path, ide_properties_file_path_bckup)

    idea_properties = []
    with open(ide_properties_file_path) as propertis_file:
        idea_properties = propertis_file.readlines()

    if idea_properties:
        for index, line in enumerate(idea_properties):
            if idea_config_path in line or idea_system_path in line:
                idea_properties[index] = f"{line.replace('#', '').replace('${user.home}', f'{ide_config_root_dir}').strip()}\n"
            elif idea_plugins_path in line:
                idea_properties[index] = f"{line.replace('#', '').replace('${idea.config.path}', f'{ide_config_root_dir}/{ide_names_config_folder_name.get(ide_name)}').strip()}\n"
            elif idea_log_path in line:
                idea_properties[index] = f"{line.replace('#', '').replace('${idea.system.path}', f'{ide_config_root_dir}/{ide_names_config_folder_name.get(ide_name)}').strip()}\n"

    with open(ide_properties_file_path, "w") as propertis_file:
        propertis_file.writelines(idea_properties)


def install_ide():
    ide_folders = get_ide_folders()
    ide_tar_file_paths = get_ide_tar_paths()

    for index, ide_tar_file_path in enumerate(ide_tar_file_paths):
        if "idea" in ide_tar_file_path:
            new_ide_tar_file_path = ide_tar_file_path.replace("ideaiu", "idea-iu")
            os.rename(ide_tar_file_path, new_ide_tar_file_path)
            ide_tar_file_paths[index] = new_ide_tar_file_path

            break

    ide_tar_file_paths_dict = {}
    sorted_ide_folders = sorted(ide_folders)

    for ide_folder_name in sorted_ide_folders:
        for ide_tar_file_path in ide_tar_file_paths:
            if ide_folder_name in ide_tar_file_path:
                ide_tar_file_paths_dict[ide_folder_name] = ide_tar_file_path

                break

    for index, ide_name in enumerate(sorted_ide_folders):
        logger.info(f"Processing ide: {ide_name}")

        ide_folder_path = ide_folders.get(ide_name)
        ide_properties_file_path = os.path.join(ide_folder_path, os.path.join("bin", "idea.properties"))

        # saved_ide_properties_file_path = os.path.join(ide_root_dir, "idea.properties")
        # if os.path.isfile(ide_properties_file_path):
        #     with open(ide_properties_file_path) as file:
        #         data = file.read()
        #
        #         with open(saved_ide_properties_file_path, "w") as new_file:
        #             new_file.write(data)

        logger.info(f"Removing contents of: {ide_folder_path}")
        shutil.rmtree(ide_folder_path)

        ide_tar_file_path = ide_tar_file_paths_dict[ide_name]
        logger.info(f"Extracting contents of: {ide_tar_file_path}")
        ide_tar_file_path = ide_tar_file_paths_dict[ide_name]
        ide_tar = tarfile.open(ide_tar_file_path)
        ide_tar.extractall(ide_root_dir)

        new_folder_name = ide_tar.getnames()[0]
        new_folder_name_extracted = new_folder_name[: new_folder_name.index("/")]
        new_folder_path_extracted = os.path.join(ide_root_dir, new_folder_name_extracted)

        new_folder_name_w_no_punctuations = new_folder_name[: new_folder_name.rindex("-")].lower()
        new_folder_path = os.path.join(ide_root_dir, new_folder_name_w_no_punctuations)

        logger.info(f"Renaming old folder {new_folder_path_extracted} -> {new_folder_path}")
        os.rename(new_folder_path_extracted, new_folder_path)

        amend_ide_config_file(ide_properties_file_path, ide_name)

        # logger.info(f"Renaming default file properties at: {ide_properties_file_path}")
        # os.rename(ide_properties_file_path, f"{ide_properties_file_path}.ori")
        #
        # logger.info(f"Writing saved config to: {ide_properties_file_path}")
        # if os.path.isfile(saved_ide_properties_file_path):
        #     with open(saved_ide_properties_file_path) as file:
        #         data = file.read()
        #
        #         with open(ide_properties_file_path, "w") as new_file:
        #             new_file.write(data)

    clean_ide_install_files(ide_tar_file_paths)


if __name__ == "__main__":
    install_ide()

    # amend_ide_config_file("/mnt/SSD-1/ide/webstorm/bin/idea.properties.ori", "webstorm")
