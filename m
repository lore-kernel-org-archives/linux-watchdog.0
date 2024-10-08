Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E701C231E;
	Tue,  8 Oct 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377337; cv=none; b=M2gsC6QKp8EIqQc1pQ+GahZIoh8OyvqNMxoDafuwHINsZUw68psmP7ll4jiO0Mb4H8paAvkbLtElvDgh8NKOEPZSGEsdx5MzbLQdZhOsNXyzEOWEvJvQm1orOtnfwvTw2+iS/mQmhWUWKE0G+yuELm4bWsh+Kbn7RPhCX8C+1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377337; c=relaxed/simple;
	bh=NCPYzTGYfBLkgRBCCxhfCOO94oU9WxQTrSRTThzoqoU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EzKjx2KzPXdE/eVoxNcUeJ5T0zq3iiCMRBvkP7KkW/ChiWZjh8WruFI9q/v9sU1G9IHIu+OuevQOMlUp6S3sVdT4pR3a5vYlZEh43My3HzPsv5lSaTu5T3C/oPcLjhxBOpojcciChA6+xeGScbPuQEHKi25hdZOwUNpOy1wQ8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86704f1eee9c-1ded5;
	Tue, 08 Oct 2024 16:48:46 +0800 (CST)
X-RM-TRANSID:2ee86704f1eee9c-1ded5
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86704f1ed85a-94cf6;
	Tue, 08 Oct 2024 16:48:46 +0800 (CST)
X-RM-TRANSID:2ee86704f1ed85a-94cf6
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] drivers/pcwd_pci:Fix the wrong format specifier
Date: Tue,  8 Oct 2024 01:48:44 -0700
Message-Id: <20241008084844.13751-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The format specifier of "int" in printf() should be "%d", not
"%u".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/watchdog/pcwd_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index a489b426f2ba..3672e7f23b39 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -230,7 +230,7 @@ static void pcipcwd_show_card_info(void)
 	got_fw_rev = send_command(CMD_GET_FIRMWARE_VERSION, &fw_rev_major,
 								&fw_rev_minor);
 	if (got_fw_rev)
-		sprintf(fw_ver_str, "%u.%02u", fw_rev_major, fw_rev_minor);
+		sprintf(fw_ver_str, "%d.%02d", fw_rev_major, fw_rev_minor);
 	else
 		sprintf(fw_ver_str, "<card no answer>");
 
-- 
2.17.1



