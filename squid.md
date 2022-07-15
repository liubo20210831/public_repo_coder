```sh
squid -k parse
squid -k reconfigure

```

```sh
aws ecs describe-tasks \
    --cluster DevClusterFARGATE  \
    --tasks 5afae34b73324f7083e462c3a600d0bb

```

```sh
aws ecs update-service \
    --cluster DevClusterFARGATE \
    --enable-execute-command \
    --service squid_service \
    --desired-count 1



aws ecs execute-command --cluster DevClusterFARGATE  \
    --task 825afd0c9b824b8284df4255d0925d9e \
    --container squid \
    --interactive \
    --command "/bin/sh"

# 安装session-manager-working-with-install-plugin
# https://docs.aws.amazon.com/zh_cn/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html#install-plugin-linux

aws ecs execute-command --cluster DevClusterFARGATE    --task b5f88981d02140e58204710508bb2201   --container squid   --interactive   --command "/bin/sh"

# aws ecs update-service     --cluster DevClusterFARGATE     --enable-execute-command     --service squid_service     --desired-count 0


task_arn=`aws ecs list-tasks --cluster DevClusterFARGATE --service-name squid_service --query taskArns[0] --output text`
echo $task_arn
if [[ "$task_arn" != "None" ]]
then
    echo `date "+%Y-%m-%d %H:%M:%S"` "INFO: task arn is" $task_arn
    task_id=${task_arn##*/} # # ##Indicates interception, separated by the character "/", delete the string on the left, and keep the string on the right
    echo  `date "+%Y-%m-%d %H:%M:%S"` "INFO: task id is" $task_id
    aws ecs execute-command --cluster $STG_CLUSTER_NAME --task $task_id --container squid   --interactive   --command "squid -k reconfigure"
else
    echo `date "+%Y-%m-%d %H:%M:%S"` "ERROR: task arn is None"

```
