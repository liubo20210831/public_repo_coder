export CLUSTER_NAME=DevClusterFARGATE
export SERVICE_NAME=squid_service
task_arn=`aws ecs list-tasks --cluster DevClusterFARGATE --service-name $SERVICE_NAME --query taskArns[0] --output text`
if [[ "$task_arn" != "None" ]]
then
    echo `date "+%Y-%m-%d %H:%M:%S"` "INFO: task arn is" $task_arn
    task_id=${task_arn##*/} # # ##Indicates interception, separated by the character "/", delete the string on the left, and keep the string on the right
    echo  `date "+%Y-%m-%d %H:%M:%S"` "INFO: task id is" $task_id
    aws ecs execute-command --cluster $CLUSTER_NAME --task $task_id --container squid --interactive --command "squid -k parse"
    aws ecs execute-command --cluster $CLUSTER_NAME --task $task_id --container squid --interactive --command "squid -k reconfigure"
else
    echo `date "+%Y-%m-%d %H:%M:%S"` "ERROR: service ${SERVICE_NAME} have no task running, task arn is None"
    exit 1
fi
