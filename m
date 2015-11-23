Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:47710 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbKWPMt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:12:49 -0500
From: Harald Geyer <harald@ccbib.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Vivien Didelot <vivien.didelot@savoirlinux.com>
Subject: Re: In-reply-to: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
In-reply-to: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1703.1448290971.1@stardust.g4.wien.funkfeuer.at>
Date: Mon, 23 Nov 2015 16:02:52 +0100
Message-Id: <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

sorry for breaking the threading. Only stumbled upon this message in the
webarchive of the Mailinglist and couldn't reconstruct full headers ...

I think there is an issue with your patch:

+static int watchdog_reboot_notifier(struct notifier_block *nb,
+				    unsigned long code, void *data)
+{
+	struct watchdog_device *wdd = container_of(nb, struct watchdog_device,
+						   reboot_nb);
+
+	if (code == SYS_DOWN || code == SYS_HALT) {

I think you want this to be (code == SYS_POWER_OFF || code == SYS_HALT)
AFAIK SYS_DOWN is the code for a reboot, where the system should come
back up immediatly, so probably we shouldn't disable the watchdog in
this case, for the system might crash during going down.

More importantly however we should stop the watchdog on SYS_POWER_OFF
I think.

Otherwise your series looks good to me and I look forward to rebase
my own patches on it.

HTH,
Harald

+		if (watchdog_active(wdd)) {
+			int ret;
+
+			ret = wdd->ops->stop(wdd);
+			if (ret)
+				return NOTIFY_BAD;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
