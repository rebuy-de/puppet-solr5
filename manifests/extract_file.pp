define solr5::extract_file( 
  $path_to_archive,
  $archive_filename=$name,
  $file_to_extract,
){
  exec { "${name}":
    command => "tar --extract --file ${path_to_archive}/${archive_filename} --wildcards --no-anchored '${file_to_extract}' -O > ${path_to_archive}/${file_to_extract} ",
    cwd     => "${path_to_archive}",
    path    => "/bin/",
    creates => "${path_to_archive}/${file_to_extract}"
  }
}
