-- Raise the Conversion Points standard, so that barbarian clans don't accidentally convert to a Free-City

UPDATE "GlobalParameters"
SET
    "Value" = "Value" + 10
WHERE "Name" = 'BARBARIAN_CLANS_CIV_CONVERSION_POINTS_STANDARD';

-- Create a new Notification

INSERT OR REPLACE INTO "Types"
	(	"Type",								"Kind"				)
VALUES
	(	'NOTIFICATION_INJECT_FREE_CITY',	'KIND_NOTIFICATION'	);

INSERT OR REPLACE INTO "Notifications"
	(	"NotificationType",					"SeverityType",	"Summary",	"ExpiresEndOfTurn",	"ExpiresEndOfNextTurn",	"AutoNotify",	"GroupType",	"AutoActivate",	"VisibleInUI",	"ShowIconSinglePlayer"	)
VALUES
	(	'NOTIFICATION_INJECT_FREE_CITY',	'HIGH',			NULL,		1,					0,						0,				NULL,			0,				1,				1						);
