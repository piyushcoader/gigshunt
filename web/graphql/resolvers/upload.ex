defmodule GigsHunt.Uploads do
  def upload(%{"file" => file}) do
    file_extension = Path.extname(file.filename)


    # Generate the UUID
    file_uuid = UUID.uuid4(:hex)

    # Set the S3 filename
    s3_filename = "#{file_uuid}#{file_extension}"

    # The S3 bucket to upload to
    s3_bucket = "gigshunt"

    # Load the file into memory
    {:ok, file_binary} = File.read(file.path)

    IO.puts s3_filename

    # Upload the file to S3
    {:ok, result} =
      ExAws.S3.put_object(s3_bucket, s3_filename, file_binary)
      |> ExAws.request()

    IO.inspect result

    {result, "https://s3-us-west-2.amazonaws.com/gigshunt/#{s3_filename}"}
  end
end
