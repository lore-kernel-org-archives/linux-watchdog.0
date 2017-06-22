Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:54057 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdFVNVy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Jun 2017 09:21:54 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
Subject: [PATCH 1/5 v2] Extend the request_region() infrastructure
Date: Thu, 22 Jun 2017 15:21:30 +0200
Message-Id: <20170622132134.7200-2-zboszor@pr.hu>
In-Reply-To: <20170622132134.7200-1-zboszor@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add a new IORESOURCE_ALLOCATED flag that is automatically used
when alloc_resource() is used internally in kernel/resource.c
and free_resource() now takes this flag into account.

The core of __request_region() was factored out into a new function
called __request_declared_region() that needs struct resource *
instead of the (start, n, name) triplet.

These changes allow using statically declared struct resource
data coupled with the pre-existing DEFINE_RES_IO_NAMED() static
initializer macro. The new macro exploiting
__request_declared_region() is request_declared_muxed_region()

v2:

Fixed checkpatch.pl warnings and errors and extended the macro
API with request_declared_region() and release_declared_region()

Reversed the order of __request_declared_region and __request_region

Added high level description of the muxed and declared variants
of the macros.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 include/linux/ioport.h | 14 ++++++++++++++
 kernel/resource.c      | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6230064..6ebcd39 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -52,6 +52,7 @@ struct resource {
 #define IORESOURCE_MEM_64	0x00100000
 #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
 #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
+#define IORESOURCE_ALLOCATED	0x00800000	/* Resource was allocated */
 
 #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
 #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
@@ -215,7 +216,14 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
+#define request_declared_region(res)		__request_region( \
+							&ioport_resource, \
+							(res), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
+#define request_declared_muxed_region(res)	__request_declared_region( \
+							&ioport_resource, \
+							(res), \
+							IORESOURCE_MUXED)
 #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)
 #define request_mem_region_exclusive(start,n,name) \
@@ -227,8 +235,14 @@ extern struct resource * __request_region(struct resource *,
 					resource_size_t n,
 					const char *name, int flags);
 
+extern struct resource *__request_declared_region(struct resource *parent,
+					struct resource *res, int flags);
+
 /* Compatibility cruft */
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
+#define release_declared_region(res)	__release_region(&ioport_resource, \
+						(res)->start, \
+						(res)->end - (res)->start + 1)
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
 extern void __release_region(struct resource *, resource_size_t,
diff --git a/kernel/resource.c b/kernel/resource.c
index 9b5f044..2be7029 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -184,6 +184,9 @@ static void free_resource(struct resource *res)
 	if (!res)
 		return;
 
+	if (!(res->flags & IORESOURCE_ALLOCATED))
+		return;
+
 	if (!PageSlab(virt_to_head_page(res))) {
 		spin_lock(&bootmem_resource_lock);
 		res->sibling = bootmem_resource_free;
@@ -210,6 +213,8 @@ static struct resource *alloc_resource(gfp_t flags)
 	else
 		res = kzalloc(sizeof(struct resource), flags);
 
+	res->flags = IORESOURCE_ALLOCATED;
+
 	return res;
 }
 
@@ -1110,8 +1115,19 @@ resource_size_t resource_alignment(struct resource *res)
  * the IO flag meanings (busy etc).
  *
  * request_region creates a new busy region.
+ * The resource descriptor is allocated by this function.
+ *
+ * request_declared_region creates a new busy region
+ * described in an existing resource descriptor.
+ *
+ * request_muxed_region creates a new shared busy region.
+ * The resource descriptor is allocated by this function.
+ *
+ * request_declared_muxed_region creates a new shared busy region
+ * described in an existing resource descriptor.
  *
  * release_region releases a matching busy region.
+ * The region is only freed if it was allocated.
  */
 
 static DECLARE_WAIT_QUEUE_HEAD(muxed_resource_wait);
@@ -1128,7 +1144,6 @@ struct resource * __request_region(struct resource *parent,
 				   resource_size_t start, resource_size_t n,
 				   const char *name, int flags)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct resource *res = alloc_resource(GFP_KERNEL);
 
 	if (!res)
@@ -1138,6 +1153,26 @@ struct resource * __request_region(struct resource *parent,
 	res->start = start;
 	res->end = start + n - 1;
 
+	if (!__request_declared_region(parent, res, flags)) {
+		free_resource(res);
+		res = NULL;
+	}
+
+	return res;
+}
+EXPORT_SYMBOL(__request_region);
+
+/**
+ * __request_declared_region - create a new busy resource region
+ * @parent: parent resource descriptor
+ * @res: child resource descriptor
+ * @flags: IO resource flags
+ */
+struct resource *__request_declared_region(struct resource *parent,
+				   struct resource *res, int flags)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
 	write_lock(&resource_lock);
 
 	for (;;) {
@@ -1166,14 +1201,13 @@ struct resource * __request_region(struct resource *parent,
 			continue;
 		}
 		/* Uhhuh, that didn't work out.. */
-		free_resource(res);
 		res = NULL;
 		break;
 	}
 	write_unlock(&resource_lock);
 	return res;
 }
-EXPORT_SYMBOL(__request_region);
+EXPORT_SYMBOL(__request_declared_region);
 
 /**
  * __release_region - release a previously reserved resource region
-- 
2.9.4

