Return-path: <panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
To: wim@iguana.be
Cc: dyoung@redhat.com, dzickus@redhat.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, Pratyush Anand <panand@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 1/2] watchdog: Use static struct class watchdog_class in stead of pointer
Date: Thu, 17 Dec 2015 17:53:58 +0530
Message-Id: <b45250982479cf4a8a59b84bda7c058e424a88e8.1450353452.git.panand@redhat.com>
In-Reply-To: <cover.1450353452.git.panand@redhat.com>
References: <cover.1450353452.git.panand@redhat.com>
In-Reply-To: <cover.1450353452.git.panand@redhat.com>
References: <cover.1450353452.git.panand@redhat.com>
List-ID: <linux-watchdog@vger.kernel.org>

We need few sysfs attributes to know different status of a watchdog device.
To do that, we need to associate .dev_groups with watchdog_class. So
convert it from pointer to static.
Putting this static struct in watchdog_dev.c, so that static device
attributes defined in that file can be attached to it.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_core.c | 15 ++-------------
 drivers/watchdog/watchdog_core.h |  2 +-
 drivers/watchdog/watchdog_dev.c  | 26 ++++++++++++++++++++++----
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 873f13972cf4..a55e846eec79 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -285,19 +285,9 @@ static int __init watchdog_deferred_registration(void)
 
 static int __init watchdog_init(void)
 {
-	int err;
-
-	watchdog_class = class_create(THIS_MODULE, "watchdog");
-	if (IS_ERR(watchdog_class)) {
-		pr_err("couldn't create class\n");
+	watchdog_class = watchdog_dev_init();
+	if (IS_ERR(watchdog_class))
 		return PTR_ERR(watchdog_class);
-	}
-
-	err = watchdog_dev_init();
-	if (err < 0) {
-		class_destroy(watchdog_class);
-		return err;
-	}
 
 	watchdog_deferred_registration();
 	return 0;
@@ -306,7 +296,6 @@ static int __init watchdog_init(void)
 static void __exit watchdog_exit(void)
 {
 	watchdog_dev_exit();
-	class_destroy(watchdog_class);
 	ida_destroy(&watchdog_ida);
 }
 
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 6c951418fca7..1c8d6b0e68c7 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -33,5 +33,5 @@
  */
 extern int watchdog_dev_register(struct watchdog_device *);
 extern int watchdog_dev_unregister(struct watchdog_device *);
-extern int __init watchdog_dev_init(void);
+extern struct class * __init watchdog_dev_init(void);
 extern void __exit watchdog_dev_exit(void);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 56a649e66eb2..055a4e1b4c13 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -581,18 +581,35 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 	return 0;
 }
 
+static struct class watchdog_class = {
+	.name =		"watchdog",
+	.owner =	THIS_MODULE,
+};
+
 /*
  *	watchdog_dev_init: init dev part of watchdog core
  *
  *	Allocate a range of chardev nodes to use for watchdog devices
  */
 
-int __init watchdog_dev_init(void)
+struct class * __init watchdog_dev_init(void)
 {
-	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
-	if (err < 0)
+	int err;
+
+	err = class_register(&watchdog_class);
+	if (err < 0) {
+		pr_err("couldn't register class\n");
+		return ERR_PTR(err);
+	}
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
-	return err;
+		class_unregister(&watchdog_class);
+		return ERR_PTR(err);
+	}
+
+	return &watchdog_class;
 }
 
 /*
@@ -604,4 +621,5 @@ int __init watchdog_dev_init(void)
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	class_unregister(&watchdog_class);
 }
-- 
2.5.0
