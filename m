Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04B41A553
	for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476969; cv=pass; b=hR4Jj4MMGMrdGfXmUbeIwEvzjJ6sBfpGCK+SOFLPBZUDqBXCcOXVNhFEy3e1X0P4EMS3IpXdkDDb2f6o/wIg3+g7sAHUxg3aJuCTMgz5oqstI6sibaaQgOu6D9fQZzmh6kHMMo3IO0T+Qp7gyB/8rFvbGCTD1TF1/yPnogJw8VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476969; c=relaxed/simple;
	bh=oJRiHdKN1YapCG/8O2p/nhvg40mgj3MhZjzmhnbecTE=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=emh/RKwkhvlRaXgykNDncY7Q7eymI0MapabMjdRfZs6cmG88OBRva9ATIya80ovTx7Dxs+WhyqtbxhZDZbzvgYhfZICsxvNIDu8SfLex5U25frXAHTrDKMEC5F45N8uz/OO6oJKLqMnirdvxtacIlCZ/hCTzB4ptdPmz3SvbHA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7MdhJrx; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7MdhJrx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso13224125e9.0
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 05:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476966; cv=none;
        d=google.com; s=arc-20260327;
        b=huwP/J/X+XJ31TqgDPwiPoPPOuneO58bQq1Ok/pFi2wkrKUKf6tbZZWf09hf42+E/y
         1iXz/qUzGreYoUwXz2kik+7BdyUIWER0yN7ptPbx10f8Hd+GnqLNIW2rV2g/FGxg4fGY
         R8JJAy8nM9zt0gM5zaxOwmZ3pY8imRaPECEz7gD3kfDYbZpWVAMsDAfqBgpBtgVBce0E
         tKyr5SqVJ9J21cNQmDZgaRCuR9kfDH3Iko0PGB9nwuaODydaOu3lFHRRz7HjXcv5pFPj
         KoTkDs+KUYNEZC7ZLGzxRLz5dwRSkd+skZaR21jCGXdzkDUR4fRPUeHH58OSUM/GiCgx
         34rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=3vwHYsBxkGYOfWmZtOuIuEPnnDeTS+KPkPMpde8JjIk=;
        fh=CE8pYuvm1+3m3Agiml7Cfa9VrFtbFVFckWO11LESfHU=;
        b=YY6HIJv0+ctiiVCvCRpe0VCEaJxIkDGRYfE3IMkgDArC5zf38ZVV5PuARdbX7uEWin
         7oNpZq60EZGQ51npAH4MWp/WRtN1E1GuLSgJvcpezEnsXnYL0bQRecc0Cdwbxo3zkrak
         LcOsHfVIdodj/4JY/Q4bhmVc362KO1Q3Y8J5aixg18TGkDtvU4C9+HfoZWAQHrWo+Kgp
         pNiLZP9pka7LpP3Stpp8cS41dqMton0618httLD9myuKmvQlwl5CK+ucI6yNPHywrhTV
         wnrmH/hJcEsywcEnogAQ0+lpHJPD+krBosTZghizlTEXSG2x2mzcswmOEfrIVfaoHi8C
         rKig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476966; x=1790081766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vwHYsBxkGYOfWmZtOuIuEPnnDeTS+KPkPMpde8JjIk=;
        b=a7MdhJrxcecPsAhOmFchO9UBjhPpWBehEfTEBnPPGQ5tho3TqirQ3BUDfU/TNL3IZq
         rMME4oIiL44ANY0njdPgKyr2PikuereZMWTGU2gyP8qp5rQMVfwtpRyc4UUmMI6uwQzg
         3yEGKWEgqDN8V6p5HB7U7spUJan/P3/5qF/+XK864/EvPffZU/K/zkLElvy2taZ5l1Ip
         LMQd1jFs6SJ0RwAXFlW+21EjcXBKX28hQRPNISJ1tH1gBbQk/H7AW9DMaAJ4G5kVfDeQ
         VmM5EmTOuBZpCw4DEWSw8eqigsOfwzEamsGMXz+2tBSInksVnyYK4x2PF+CwE+6iMey5
         jznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476966; x=1790081766;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3vwHYsBxkGYOfWmZtOuIuEPnnDeTS+KPkPMpde8JjIk=;
        b=g8XXnmaXbmxBxeQEKS9Fo8XiLvMfYSMsml1rNp/Pk9ap2mlUqpYHjBq++IO+ZZKavT
         lNR38Q+nxeTwBp439nYl7DPpuzWd/3zJPTZcH4mTbUvo1lraCdZn7+7Q7gqWGPnVKBx4
         iwRinXPlP4YyEhjzTu+Wf4hamy3SpC2Kmb86fJn9EkvsOxsdWSAyJ9xIkep5ug05SxKu
         UZAD3rretLdHdqRH5O1kIGmBIfd2vpqDjVX7kQ/wkfLkacJLaaLkcRGkgWY9k7Pgb9Bl
         HLEhtlCWLJmLmoe0AXNKWqOSfmYGPleVijU/loRZ3UUB2zoirvtDL3kNXAEXiE61nQaJ
         kBvg==
X-Gm-Message-State: AFuF++nCiOM7EsS/lvws5TrYGGt4YOZXfcsu8D0hu8WFGj0dnXgAf/Du
	6zQe1OdiRp+IYTMCDlByGQ0+PwT2MQE8z+t6m3kL7w67q2Yvj9s7fzu847y7kXQIGEyELPwUg+t
	iNV+/Bgs06XczYrRJrPIWkN9uYR87GkEefVKpTq7RQgBx
X-Gm-Gg: AYBFou0im2gOgzIBfRomUZ7hkTg0MlTUcMaWLKJDnX1U7gjodLVixoQtBVyFOn1ZgEW
	3FOEyvI5Mj5Wj78ZlSv/WJoHMbD1AmHF1tvMh67thPHi+BMzdBisMk8ZNwkyPLNHEQAFdDVAJpS
	rHnNghSljO7J5NuVtpYoEKC5WRUDaEdC9xAdF6nLaAEEKutCQMBweY3h5AzUmcrFIqSjqft8f3m
	lAsP16S7V6O281vLyz+gDCrC4yUPaj8jtsG8D5HtT2ctI3o4wQ7Zw9CgpbtNhwPCEMxIS0Ij1lN
	ySLC9oGMixFbjO3xVyv6UjZV32RilIdJdt6rcyjS78GyZkjOFb6o1Q==
X-Received: by 2002:a05:600c:628f:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49e7a66ae3dmr80572605e9.21.1789476966059; Tue, 15 Sep 2026
 05:56:06 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:05 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:05 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:05 -0700
X-Gm-Features: AcwNN1UdnZGkqQ-YVPVZckrR1j7Pz6GE1GRGQQRjJRBu2iux0dtM6krRz_3AvTw
Message-ID: <CAF9RqJ5zHTLu2xpr02u781dvDG+MXiRS5WmCarMZFsQ2U4TAQQ@mail.gmail.com>
Subject: [PATCH] watchdog: davinci_wdt: fix comment typo
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org, linux@roeck-us.net, 
	Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/watchdog/davinci_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 6ea0434f45c2..748dd24affb3 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -120,7 +120,7 @@ static unsigned int
davinci_wdt_get_timeleft(struct watchdog_device *wdd)
 	u32 val;
 	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);

-	/* if timeout has occured then return 0 */
+	/* if timeout has occurred then return 0 */
 	val = ioread32(davinci_wdt->base + WDTCR);
 	if (val & WDFLAG)
 		return 0;
-- 
2.54.0.windows.1
