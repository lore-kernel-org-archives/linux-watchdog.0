Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@ekass.net,
	wim@iguana.be,
	jlayton@poochiereds.net,
	marc.2377@gmail.com,
	cshorler@googlemail.com,
	wsa@the-dreams.de,
	regressions@leemhuis.info,
	Alex Williamson <alex.williamson@redhat.com>,
	lyude@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jakub Sitnicki <jsitnicki@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Travis <travis@sgi.com>,
	Daeseok Youn <daeseok.youn@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	Andiry Xu <andiry.xu@amd.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Alexandre Desnoyers <alex@qtec.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wan ZongShun <Vincent.Wan@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <dev@lynxeye.de>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	=?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>
Subject: [PATCH 2/5 v3] Modify behaviour of request_*muxed_region()
Date: Mon, 18 Dec 2017 09:48:38 +0100
Message-Id: <20171218084841.9979-2-zboszor@pr.hu>
In-Reply-To: <20171218084841.9979-1-zboszor@pr.hu>
References: <20171218084841.9979-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Böszörményi Zoltán <zboszor@pr.hu>

In order to make request_*muxed_region() behave more like
mutex_lock(), a possible failure case needs to be eliminated.
When drivers do not properly share the same I/O region, e.g.
one is using request_region() and the other is using
request_muxed_region(), the kernel didn't warn the user about it.
This change modifies IORESOURCE_MUXED behaviour so it always
goes to sleep waiting for the resuorce to be freed and the
inconsistent resource flag usage is logged with KERN_ERR.

v2: Fixed checkpatch.pl warnings and extended the comment
    about request_declared_muxed_region.

v3: Rebased for 4.15-rc4

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 kernel/resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 05db9c4e3992..0f26f887ac33 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1143,6 +1143,7 @@ resource_size_t resource_alignment(struct resource *res)
  *
  * request_declared_muxed_region creates a new shared busy region
  * described in an existing resource descriptor.
+ * It only returns if it succeeded.
  *
  * release_region releases a matching busy region.
  * The region is only freed if it was allocated.
@@ -1209,7 +1210,10 @@ struct resource *__request_declared_region(struct resource *parent,
 				continue;
 			}
 		}
-		if (conflict->flags & flags & IORESOURCE_MUXED) {
+		if (flags & IORESOURCE_MUXED) {
+			if (!(conflict->flags & IORESOURCE_MUXED))
+				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
+					res->name, conflict->name);
 			add_wait_queue(&muxed_resource_wait, &wait);
 			write_unlock(&resource_lock);
 			set_current_state(TASK_UNINTERRUPTIBLE);
-- 
2.13.6
