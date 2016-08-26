Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49338 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbcHZQIQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 12:08:16 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH v4 6/7] watchdog: pretimeout: add option to select a pretimeout governor in runtime
Date: Fri, 26 Aug 2016 19:08:00 +0300
Message-ID: <1472227681-1405-7-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The change converts watchdog device attribute "pretimeout_governor" from
read-only to read-write type to allow users to select a desirable
watchdog pretimeout governor in runtime, e.g.

  % echo -n panic > /sys/..../watchdog/watchdog0/pretimeout

To get this working a list of registered pretimeout governors is created
and a new helper function watchdog_pretimeout_governor_set() is exported
to watchdog_dev.c.

If a selected governor is gone, a watchdog device pretimeout notification
is delegated to a default built-in pretimeout governor.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v3 to v4:
* new change, this functional change was removed in v3

Changes from v2 1/4 to v4:
* introduced watchdog_pretimeout_governor_set() and moved device
  attribute registration to watchdog_dev.c
* fixed a list element deregistration bug

 drivers/watchdog/watchdog_dev.c        | 15 ++++++-
 drivers/watchdog/watchdog_pretimeout.c | 76 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.h |  8 ++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 3837269562a2..af5791d49b73 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -497,7 +497,20 @@ static ssize_t pretimeout_governor_show(struct device *dev,
 
 	return watchdog_pretimeout_governor_get(wdd, buf);
 }
-static DEVICE_ATTR_RO(pretimeout_governor);
+
+static ssize_t pretimeout_governor_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+	int ret = watchdog_pretimeout_governor_set(wdd, buf);
+
+	if (!ret)
+		ret = count;
+
+	return ret;
+}
+static DEVICE_ATTR_RW(pretimeout_governor);
 
 static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 				int n)
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 098c965f6c78..d60a5d5b3cd1 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -29,6 +29,29 @@ struct watchdog_pretimeout {
 	struct list_head		entry;
 };
 
+/* The mutex protects governor list and serializes external interfaces */
+static DEFINE_MUTEX(governor_lock);
+
+/* List of the registered watchdog pretimeout governors */
+static LIST_HEAD(governor_list);
+
+struct governor_priv {
+	struct watchdog_governor	*gov;
+	struct list_head		entry;
+};
+
+static struct governor_priv *find_governor_by_name(const char *gov_name)
+{
+	struct governor_priv *priv;
+
+	list_for_each_entry(priv, &governor_list, entry)
+		if (!strncmp(gov_name, priv->gov->name,
+			     WATCHDOG_GOV_NAME_MAXLEN))
+			return priv;
+
+	return NULL;
+}
+
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 {
 	int count = 0;
@@ -41,6 +64,28 @@ int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 	return count;
 }
 
+int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
+				     const char *buf)
+{
+	struct governor_priv *priv;
+
+	mutex_lock(&governor_lock);
+
+	priv = find_governor_by_name(buf);
+	if (!priv) {
+		mutex_unlock(&governor_lock);
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&pretimeout_lock);
+	wdd->gov = priv->gov;
+	spin_unlock_irq(&pretimeout_lock);
+
+	mutex_unlock(&governor_lock);
+
+	return 0;
+}
+
 void watchdog_notify_pretimeout(struct watchdog_device *wdd)
 {
 	unsigned long flags;
@@ -59,6 +104,22 @@ EXPORT_SYMBOL_GPL(watchdog_notify_pretimeout);
 int watchdog_register_governor(struct watchdog_governor *gov)
 {
 	struct watchdog_pretimeout *p;
+	struct governor_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_lock(&governor_lock);
+
+	if (find_governor_by_name(gov->name)) {
+		mutex_unlock(&governor_lock);
+		kfree(priv);
+		return -EBUSY;
+	}
+
+	priv->gov = gov;
+	list_add(&priv->entry, &governor_list);
 
 	if (!strncmp(gov->name, WATCHDOG_PRETIMEOUT_DEFAULT_GOV,
 		     WATCHDOG_GOV_NAME_MAXLEN)) {
@@ -71,6 +132,8 @@ int watchdog_register_governor(struct watchdog_governor *gov)
 		spin_unlock_irq(&pretimeout_lock);
 	}
 
+	mutex_unlock(&governor_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL(watchdog_register_governor);
@@ -78,12 +141,25 @@ EXPORT_SYMBOL(watchdog_register_governor);
 void watchdog_unregister_governor(struct watchdog_governor *gov)
 {
 	struct watchdog_pretimeout *p;
+	struct governor_priv *priv, *t;
+
+	mutex_lock(&governor_lock);
+
+	list_for_each_entry_safe(priv, t, &governor_list, entry) {
+		if (priv->gov == gov) {
+			list_del(&priv->entry);
+			kfree(priv);
+			break;
+		}
+	}
 
 	spin_lock_irq(&pretimeout_lock);
 	list_for_each_entry(p, &pretimeout_list, entry)
 		if (p->wdd->gov == gov)
 			p->wdd->gov = default_gov;
 	spin_unlock_irq(&pretimeout_lock);
+
+	mutex_unlock(&governor_lock);
 }
 EXPORT_SYMBOL(watchdog_unregister_governor);
 
diff --git a/drivers/watchdog/watchdog_pretimeout.h b/drivers/watchdog/watchdog_pretimeout.h
index 8f9804c2dd88..afb868eedc65 100644
--- a/drivers/watchdog/watchdog_pretimeout.h
+++ b/drivers/watchdog/watchdog_pretimeout.h
@@ -19,6 +19,8 @@ void watchdog_unregister_governor(struct watchdog_governor *gov);
 int watchdog_register_pretimeout(struct watchdog_device *wdd);
 void watchdog_unregister_pretimeout(struct watchdog_device *wdd);
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf);
+int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
+				     const char *buf);
 
 #if IS_ENABLED(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)
 #define WATCHDOG_PRETIMEOUT_DEFAULT_GOV		"panic"
@@ -41,6 +43,12 @@ static inline int watchdog_pretimeout_governor_get(struct watchdog_device *wdd,
 {
 	return -EINVAL;
 }
+
+static inline int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
+						   const char *buf)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif
-- 
2.8.1

