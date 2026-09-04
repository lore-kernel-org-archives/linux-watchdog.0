Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE3476078
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521874; cv=none; b=oElzTLdPk18Zpr/BUNw5pNOZ31lf2GoKhFuNzNX4c76of/0S38tRLlrd5oEAP9xzqwtPjtQginBPRRjOu+vddjG7+1FXzwMh9HVFZIq72kvGXzgSFKfirIgmZB5R3sbf6nxN70DalEAdu+79FxfwbKX8ZylcteuTkus3S33txsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521874; c=relaxed/simple;
	bh=zL/wt+2D7/0Ng/ZTxiOzTvTVNJVLv66apNuBFy3C+zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpmq3daUolR2tRUnlCD2pVzBRjHZqtWQo++BHPV+VJLC0jPke/nTcKlrWSHU3GcslTNhjS+D5NwB92DursdbShYfbC1B5cyNpcbABJEDTxJ60IdvjSbkEJc6Y0WJl27XtnNKdmLY47vAkrBVmiW5NbcaaqSY2Vjp97VYibcP70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebn3mA+S; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebn3mA+S"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso719039eaf.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 04:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521871; x=1789126671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZeQkMTJNiBbmeCpigeJTN24zonEe8584ZhFeJSidNw=;
        b=Ebn3mA+SrN29WBPjzBgrvh51iuHaREg3A5LYLuM//20YHkAVFfmpH/93E6BWbjcQ3f
         CpBVP4n7ILxNvCFLpjgeRmUWFBa0gFfKLtqWrQPcx6zlhBzfpHx6tyU5kksM+18Xtv+k
         vUpqTBfHua0SQQBgtFHh27OBqGz6KKHutJbHP6L8K+OIMFK1h/fb7kJh4Oo34b25ZUgS
         lHLcL2y+ggMXd5k8xXf14pxk46dlSxAqvjUbKY/DUaZoyZyuRiRwdI7V0kxwsIMC8ZlT
         B5jli8IzgbUoM8mXSEDkeh3rU+4POFN6ofnNug6+sQye7BzheWhOdtoP5kFDOETdn3yg
         yHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521871; x=1789126671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cZeQkMTJNiBbmeCpigeJTN24zonEe8584ZhFeJSidNw=;
        b=NyopOCvYqTyNyGVzplnZfnknIJIIjlVzYriFApHuhS1ZJkkSR8Q+macMlQucJyufJP
         tj6CCqY1Rw8WlhOQey9t7VlEAhgDvMKwgCMYVMVlfvXXxT6m4Rt1DLlLttJxD8j01hQ3
         IxNKJWChAHma88wBfMI8XfMk/wdVztXo95gNGOzOBtfFYO/JLOczscRWN9iRdxaQ87BJ
         C/lQEH7O/HHxfPDZ7a4xh2/OTmusiJdFuHJVpBNvWae9e+YTQCOGXS4KGSbiXkLqOuRE
         +0L0FrlTEdbk9PnsQy+8OHlWn0ACmknoWbrTTFPtvQoqMplnaM7AAepSZ3oJZaYNt9Ke
         Ckwg==
X-Forwarded-Encrypted: i=1; AKwUvBxgVvO47RiHwZE7mvdts56/YdVwYU0iVP5zpgCZoks33M+CBhSEkx2SgB3WmpLgASzB8LFiL2cqZuPBP7DIxg==@vger.kernel.org
X-Gm-Message-State: AFuF++kDzEluq1uN/9NxrMbwlFzG7zBHz4VV87rGLG+U3xntlEKSB3Ct
	+sBUBXJ3jEzA5FZPcsIJIUPrFo1Hu24zdrnvJ1ncy+nGH7zTew0ntVmbub4UV569lQc=
X-Gm-Gg: AYBFou07R7v+QQ6ZMPFe600CJsTwqiRyyCFjlV+P2pbY4hDrjxLuOm3u1iOlEfZE+Cx
	I8vjx4DnPVLZKgXmblmEUeLO0iR7GNjugw+BY60LN8hGlRhdNpH2JHAg5Wlppgzoz+BPDGcvBKH
	4ZGI4vykC1k26qa7ZDhftJoC+3FCXY82KdCHyxstNe4TaZA0JM23I4/M3c2dN6KuxOF7YcyN/vA
	bFu/cNCHwhbBysZU2UVtm5as7pBu7s06aN4qroU7QRIcGa3F6438utzEkjzieo3x40HuDjSAF6E
	JgDiK7mG5OTBDD0EBuZ/q9ClPHONDte65juQ+yQ1lTLXr4nozlRbENOWXVvnGrin92dAnd05DZG
	LWN7jMRouIlERkffIf7fOiZxVz3eSj3MYe8f3pkolZ/G3NndbSdlClrDjWNfo9rAmOCUwMDU8vj
	+BRVvt6cdke/pJlXjEqzxC47n1DehfJ15LgX1jVjFoRHNfS3XwfgLW5kDdYiuAhlfjgvfoHESAT
	S1HAiJUAes3Lic=
X-Received: by 2002:a05:6820:220d:b0:6b1:4061:4193 with SMTP id 006d021491bc7-6b6f7988a8dmr3358295eaf.0.1788521871595;
        Fri, 04 Sep 2026 04:37:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm9102897eec.15.2026.09.04.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:37:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] watchdog: fix typos in comments
Date: Fri,  4 Sep 2026 17:07:40 +0530
Message-ID: <20260904113744.19872-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904113744.19872-1-hemanth.selam@gmail.com>
References: <20260904113744.19872-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/watchdog/davinci_wdt.c | 2 +-
 drivers/watchdog/max63xx_wdt.c | 2 +-
 drivers/watchdog/pcwd_pci.c    | 2 +-
 drivers/watchdog/pcwd_usb.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 6ea0434f45c2..748dd24affb3 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -120,7 +120,7 @@ static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
 	u32 val;
 	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
 
-	/* if timeout has occured then return 0 */
+	/* if timeout has occurred then return 0 */
 	val = ioread32(davinci_wdt->base + WDTCR);
 	if (val & WDFLAG)
 		return 0;
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index e9073df1a7de..0aecf411f91b 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -64,7 +64,7 @@ struct max63xx_wdt {
  * delay (selected with the "nodelay" parameter).
  *
  * I also decided to remove from the tables any timeout smaller than a
- * second, as it looked completly overkill...
+ * second, as it looked completely overkill...
  */
 
 /* Timeouts in second */
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index a489b426f2ba..80fc4e6d3b0a 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -114,7 +114,7 @@ static unsigned long is_active;
 static char expect_release;
 /* this is private data for each PCI-PC watchdog card */
 static struct {
-	/* Wether or not the card has a temperature device */
+	/* Whether or not the card has a temperature device */
 	int supports_temp;
 	/* The card's boot status */
 	int boot_status;
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index d7c18c990649..b923fdaaa198 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -138,7 +138,7 @@ struct usb_pcwd_private {
 	/* true if we received a report after a command */
 	atomic_t		cmd_received;
 
-	/* Wether or not the device exists */
+	/* Whether or not the device exists */
 	int			exists;
 	/* locks this structure */
 	struct mutex		mtx;
-- 
2.48.1

