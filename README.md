## Inorder to build from source use this command:
```
./build.sh [-init] [-build]
```

### init
`init` option will remove database volume, source and .. . It load code from git and aftre that runs new instanse of application.

### build
This option force to rebuild docekr image from new source. If you use it with `-init`  you can reset everythins.