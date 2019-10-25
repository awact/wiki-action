# wiki-sync-action

Github action to sync to Github wiki.  
Fork of [wiki-page-creator-action](https://github.com/Decathlon/wiki-page-creator-action)  
See [action.yml](./action.yml) for Comprehensive List of Options.  

## Usage

### `workflow.yml` Example

```yaml
name: Sync Github Wiki
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: awact/wiki-action@master
      env:
        ACTION_MAIL: shunkakinoki@gmail.com
        ACTION_NAME: shunkakinoki
        GH_PAT: ${{ secrets.GH_PAT }}
        MD_FOLDER: wiki
        OWNER: shunkakinoki
        REPO_NAME: shunkakinoki
```

## License

This project is distributed under the [MIT license](LICENSE.md).
