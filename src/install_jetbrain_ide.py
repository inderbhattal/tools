import os
import shutil
import tarfile

from utils import get_logger

logger = get_logger()

root_dir = "/mnt/SSD-1"
ide_root_dir = f"{root_dir}/ide"
ide_config_root_dir = f"{root_dir}/ide_config"

idea_properties_file_name = "idea.properties"

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
    "rustrover": ".RustRover",
    "idea-iu": ".IntelliJIdea",
}

ide_vm_options_file_names = {
    "clion": "clion64.vmoptions",
    "datagrip": "datagrip64.vmoptions",
    "goland": "goland64.vmoptions",
    "idea-iu": "idea64.vmoptions",
    "pycharm": "pycharm64.vmoptions",
    "rustrover": "rustrover64.vmoptions",
    "webstorm": "webstorm64.vmoptions",
}

ide_vm_options_changes = {
    "clion": {
        "-Xms": "-Xms256m",
        "-Xmx": "-Xmx2048m"
    },
    "datagrip": {
        "-Xms": "-Xms128m",
        "-Xmx": "-Xmx1536m"
    },
    "goland": {
        "-Xms": "-Xms256m",
        "-Xmx": "-Xmx2048m"
    },
    "idea-iu": {
        "-Xms": "-Xms256m",
        "-Xmx": "-Xmx2048m"
    },
    "pycharm": {
        "-Xms": "-Xms256m",
        "-Xmx": "-Xmx2048m"
    },
    "rustrover": {
        "-Xms": "-Xms256m",
        "-Xmx": "-Xmx2048m"
    },
    "webstorm": {
        "-Xms": "-Xms128m",
        "-Xmx": "-Xmx1536m"
    },
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


def clean_ide_install_files(ide_tar_file_paths: list):
    for ide_tar_file_path in ide_tar_file_paths:
        logger.info(f"Deleting file: {ide_tar_file_path}")

        os.remove(ide_tar_file_path)


def amend_ide_config_file(ide_folder_path: str, ide_name: str):
    ide_properties_file_path = os.path.join(ide_folder_path, os.path.join("bin", idea_properties_file_name))

    logger.info(f"Creating backup of properties file: {ide_properties_file_path}")

    ide_properties_file_path_bckup = f"{ide_properties_file_path}.ori"
    shutil.copyfile(ide_properties_file_path, ide_properties_file_path_bckup)

    with open(ide_properties_file_path) as propertis_file:
        ide_properties = propertis_file.readlines()

    if ide_properties:
        for index, config_line in enumerate(ide_properties):
            if idea_config_path in config_line or idea_system_path in config_line:
                ide_properties[index] = f"{config_line.replace('#', '').replace('${user.home}', f'{ide_config_root_dir}').strip()}\n"
            elif idea_plugins_path in config_line:
                ide_properties[index] = f"{config_line.replace('#', '').replace('${idea.config.path}', f'{ide_config_root_dir}/{ide_names_config_folder_name.get(ide_name)}').strip()}\n"
            elif idea_log_path in config_line:
                ide_properties[index] = f"{config_line.replace('#', '').replace('${idea.system.path}', f'{ide_config_root_dir}/{ide_names_config_folder_name.get(ide_name)}').strip()}\n"

    with open(ide_properties_file_path, "w") as propertis_file:
        propertis_file.writelines(ide_properties)


def amend_ide_vm_options(ide_folder_path: str, ide_name: str):
    logger.info(f"Amending VM Options for IDE: {ide_name}")

    ide_vm_options_file_name = ide_vm_options_file_names.get(ide_name, "")
    if ide_vm_options_file_name == "":
        logger.info(f"Skipping VM Options for IDE: {ide_name}")
        return

    ide_vm_options_file_path = os.path.join(ide_folder_path, os.path.join("bin", ide_vm_options_file_name))

    if not ide_vm_options_file_path or ide_vm_options_file_path == "":
        logger.error(f"{ide_vm_options_file_path} is incorrect for ide: {ide_name}")
        return

    with open(ide_vm_options_file_path) as vm_options_file:
        ide_vm_options = vm_options_file.readlines()

    ide_vm_options_change = ide_vm_options_changes.get(ide_name)
    for index, vm_option in enumerate(ide_vm_options):
        if vm_option.startswith("-Xms"):
            ide_vm_options[index] = f"{ide_vm_options_change.get('-Xms')}\n"
        elif vm_option.startswith("-Xmx"):
            ide_vm_options[index] = f"{ide_vm_options_change.get('-Xmx')}\n"

            break

    with open(ide_vm_options_file_path, "w") as propertis_file:
        propertis_file.writelines(ide_vm_options)


def install_ide():
    ide_tar_file_paths = get_ide_tar_paths()
    if not ide_tar_file_paths:
        logger.warning("No IDE tar installations files found!")
        return

    ide_folders = get_ide_folders()

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

    for ide_name, ide_tar_file_path in ide_tar_file_paths_dict.items():
        logger.info(f"Processing ide: {ide_name}")

        ide_folder_path = ide_folders.get(ide_name)

        logger.info(f"Removing contents of: {ide_folder_path}")
        shutil.rmtree(ide_folder_path)

        logger.info(f"Extracting contents of: {ide_tar_file_path}")
        ide_tar_file_path = ide_tar_file_paths_dict[ide_name]
        ide_tar = tarfile.open(ide_tar_file_path)
        ide_tar.extractall(ide_root_dir)

        new_folder_name = ide_tar.getnames()[0]
        new_folder_name_extracted = new_folder_name[: new_folder_name.index("/")] if "/" in new_folder_name else new_folder_name
        new_folder_path_extracted = os.path.join(ide_root_dir, new_folder_name_extracted)

        new_folder_name_w_no_punctuations = new_folder_name[: new_folder_name.rindex("-")].lower()
        new_folder_path = os.path.join(ide_root_dir, new_folder_name_w_no_punctuations)

        logger.info(f"Renaming old folder {new_folder_path_extracted} -> {new_folder_path}")
        os.rename(new_folder_path_extracted, new_folder_path)

        amend_ide_config_file(ide_folder_path, ide_name)

        amend_ide_vm_options(ide_folder_path, ide_name)

    clean_ide_install_files(ide_tar_file_paths)


if __name__ == "__main__":
    install_ide()
