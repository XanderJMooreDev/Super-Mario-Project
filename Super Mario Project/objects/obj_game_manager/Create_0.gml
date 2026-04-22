gpu_set_texfilter(false);

global.current_kingdom = 0;

respawnX = 0;
respawnY = 0;

playable = true;

global.cloud_platforms = ds_queue_create();

enqueue_cloud = function(cloud) {
    
    ds_queue_enqueue(global.cloud_platforms, cloud);
    
    ds_queue_tail(global.cloud_platforms).cloud_id = 1;
    ds_queue_head(global.cloud_platforms).cloud_id = 0;
}

dequeue_cloud = function() {
    if ds_queue_empty(global.cloud_platforms) {
        return;
    }
    
    instance_destroy(ds_queue_dequeue(global.cloud_platforms));
    
    if ds_queue_empty(global.cloud_platforms) {
        return;
    }
    
    ds_queue_tail(global.cloud_platforms).cloud_id = 1;
    ds_queue_head(global.cloud_platforms).cloud_id = 0;
}