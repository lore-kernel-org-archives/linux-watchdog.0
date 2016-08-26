Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v4 7/7] watchdog: pretimeout: add pretimeout_available_governors attribute
Date: Fri, 26 Aug 2016 19:08:01 +0300
Message-ID: <1472227681-1405-8-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The change adds an option to a user with CONFIG_WATCHDOG_SYSFS and
CONFIG_WATCHDOG_PRETIMEOUT_GOV enabled to get information about all
registered watchdog pretimeout governors by reading watchdog device
attribute named "pretimeout_available_governors".

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v3 to v4:
* new change, this functional change was removed in v3

Changes from v2 1/4 to v4:
* introduced watchdog_pretimeout_available_governors_get() and moved
  device attribute registration to watchdog_dev.c
* made attribute visibility more precise

 drivers/watchdog/watchdog_dev.c        | 11 ++++++++++-
 drivers/watchdog/watchdog_pretimeout.c | 15 +++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  6 ++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index af5791d49b73..13ee6bda736a 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -489,6 +489,13 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(state);
 
+static ssize_t pretimeout_available_governors_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return watchdog_pretimeout_available_governors_get(buf);
+}
+static DEVICE_ATTR_RO(pretimeout_available_governors);
+
 static ssize_t pretimeout_governor_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -524,7 +531,8 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 	else if (attr == &dev_attr_pretimeout.attr &&
 		 !(wdd->info->options & WDIOF_PRETIMEOUT))
 		mode = 0;
-	else if (attr == &dev_attr_pretimeout_governor.attr &&
+	else if ((attr == &dev_attr_pretimeout_governor.attr ||
+		  attr == &dev_attr_pretimeout_available_governors.attr) &&
 		 (!(wdd->info->options & WDIOF_PRETIMEOUT) ||
 		  !IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_GOV)))
 		mode = 0;
@@ -541,6 +549,7 @@ static struct attribute *wdt_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_nowayout.attr,
 	&dev_attr_pretimeout_governor.attr,
+	&dev_attr_pretimeout_available_governors.attr,
 	NULL,
 };
 
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index d60a5d5b3cd1..45e3895f8f71 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -52,6 +52,21 @@ static struct governor_priv *find_governor_by_name(const char *gov_name)
 	return NULL;
 }
 
+int watchdog_pretimeout_available_governors_get(char *buf)
+{
+	struct governor_priv *priv;
+	int count = 0;
+
+	mutex_lock(&governor_lock);
+
+	list_for_each_entry(priv, &governor_list, entry)
+		count += sprintf(buf + count, "%s\n", priv->gov->name);
+
+	mutex_unlock(&governor_lock);
+
+	return count;
+}
+
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 {
 	int count = 0;
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index afb868eedc65..0166dea234d6 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -18,6 +18,7 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 /* Interfaces to watchdog_dev.c */
 int watchdog_register_pretimeout(struct watchdog_device *wdd);
 void watchdog_unregister_pretimeout(struct watchdog_device *wdd);
+int watchdog_pretimeout_available_governors_get(char *buf);
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
 int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
 				     const char *buf);
@@ -38,6 +39,11 @@ static inline void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
 {
 }
 
+static inline int watchdog_pretimeout_available_governors_get(char *buf)
+{
+	return -EINVAL;
+}
+
 static inline int watchdog_pretimeout_governor_get(struct watchdog_device *wdd,
 						   char *buf)
 {
-- 
2.8.1
