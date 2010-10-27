Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933184Ab0J0Nuc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 27 Oct 2010 09:50:32 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o9RDoPSe007693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-watchdog@vger.kernel.org>; Wed, 27 Oct 2010 09:50:26 -0400
Date: Wed, 27 Oct 2010 09:50:22 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-watchdog@vger.kernel.org, wim@iguana.be,
	robert.evans@stratus.com, robert.manchek@stratus.com,
	chas.horvath@stratus.com, jparadis@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>
Message-Id: <20101027135012.15174.8589.sendpatchset@prarit.bos.redhat.com>
Subject: [PATCH]: watchdog/iTCO: remove extra pci_dev_put()'s from init code
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[Wim -- I'm not on the list so please cc me on any questions.  Also, I
had pushed two previous iTCO_wdt patches to linux-watchdog but I do not
see that they have been committed ... was there something wrong with them?

Thanks,

P. ]

The iTCO_wdt driver erroneously releases the pci_dev, and causes PCI hotremove
to fail because of an incorrect usage count.

The probe for this driver does a for_each_pci_dev() which gets a reference for
a pci_dev when iTCO_wdt_init() is successful.  The for_each_pci_dev() loop
puts a reference for a pci_dev when iTCO_wdt_init() fails, so the
iTCO_wdt_init() does not need to do any pci_dev_put()'s.

The only pci_dev_put() that is required is in the iTCO_wdt_cleanup() function.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 69de871..8135bf6 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -782,7 +782,6 @@ static int __devinit iTCO_wdt_init(struct pci_dev *pdev,
 	if (base_address == 0x00000000) {
 		/* Something's wrong here, ACPIBASE has to be set */
 		printk(KERN_ERR PFX "failed to get TCOBASE address\n");
-		pci_dev_put(pdev);
 		return -ENODEV;
 	}
 	iTCO_wdt_private.iTCO_version =
@@ -880,7 +879,6 @@ out_unmap:
 	if (iTCO_wdt_private.iTCO_version == 2)
 		iounmap(iTCO_wdt_private.gcs);
 out:
-	pci_dev_put(iTCO_wdt_private.pdev);
 	iTCO_wdt_private.ACPIBASE = 0;
 	return ret;
 }
