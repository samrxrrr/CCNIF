from ccnif.gdc import GDCClient

client = GDCClient()

print("=" * 60)
print("Checking GDC API")
print("=" * 60)

status = client.check_connection()

print(status)

print()

print("=" * 60)
print("Retrieving TCGA-LUAD metadata")
print("=" * 60)

project = client.get_project()

client.save_json(
    project,
    "data/raw/TCGA-LUAD/metadata/gdc_project_summary.json"
)

print(project)
