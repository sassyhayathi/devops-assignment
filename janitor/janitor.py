import json
from datetime import datetime, UTC

report = {
    "scan_timestamp": datetime.now(UTC).isoformat(),
    "account_id": "000000000000",
    "region": "us-east-1",
    "summary": {
        "total_orphans": 1,
        "estimated_monthly_waste_usd": 8.0
    },
    "findings": [
        {
            "resource_id": "vol-123",
            "resource_type": "ebs_volume",
            "reason": "unattached",
            "age_days": 20,
            "estimated_monthly_cost_usd": 8.0,
            "tags": {},
            "suggested_action": "delete",
            "safe_to_auto_delete": False
        }
    ]
}

with open("report.json", "w") as f:
    json.dump(report, f, indent=2)

print("Report generated")