Return-path: <mst@redhat.com>
Date: Sun, 28 Feb 2016 17:44:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH for-4.5] watchdog/rc32434_wdt: fix ioctl error handling
Message-ID: <1456674185-24670-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Calling return copy_to_user(...) in an ioctl will not do the right thing
if there's a pagefault: copy_to_user returns the number of bytes not
copied in this case.

Fix up watchdog/rc32434_wdt to do
	return copy_to_user(...)) ?  -EFAULT : 0;

instead.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Untested.

 drivers/watchdog/rc32434_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 71e78ef..3a75f3b 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -237,7 +237,7 @@ static long rc32434_wdt_ioctl(struct file *file, unsigned int cmd,
 			return -EINVAL;
 		/* Fall through */
 	case WDIOC_GETTIMEOUT:
-		return copy_to_user(argp, &timeout, sizeof(int));
+		return copy_to_user(argp, &timeout, sizeof(int)) ? -EFAULT : 0;
 	default:
 		return -ENOTTY;
 	}
-- 
MST
