Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212819;
	b=1aMHjueFM0LI7+1s+NfcL+KiM2KBxFjS1SoyNiYnSb4umgd8soBPto+7TyL7RzSmaw4K
	 gUW9AacZbWdCBB089vcgmcI0JWsekCVYw7A1kRXazZrIPA9viPPddAyOMWuxyCh0Hozjq
	 WpL7209QZnTWS1PTzpvRenOtbX5GyHDG1ZkgKxz4040LOzD9XQxKxZtoe+Q+MYwyBXl4n
	 vPNFPwgn4ZRiRajrLhmantCseuK7Ppa2KwbHKEf5GbBC9wZ2PLeqTmcFdr2uJAlZq9sKE
	 PltMOvnqoVJVpaLdTbyeugraNhaYoidmsRuGnwkXtJqDNTW+D/gDP78unZnmWVWqvQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
	b=YTkVzfQ7UQZdu/ZjxuihL6qq4MWWReFf8ADCfkGvhaqatzORt2hznlbmcb67MHTxvyi5
	 4hJ2LykplHTf3NwmSQJ2SoMRSerIiFhhqdK/niI+tQZMwGPpoEB2q7LwWjxCc0gxvTPaj
	 GnoDJkBOgr+KYbDVwt2gMl3ItKzl3O3RmaX3UO8dgRvf/Jvn7Ln91tFM/pGVhV6rP4cYL
	 pebWvwjmycd/0k9Szomax0Pp8DTLpT2f3Hok1knTt2cpGbj77Qz/R8MyQytKJejHS5vIr
	 xCtIWRmtI5UVyXJOOWPkDZk4R59l3yope7SjFbP37qo2CR428mbKMQU0QMtYZLWZ7pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oWP+Rohp;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A552606A335
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 08:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A552606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oWP+Rohp
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-497614c95f0so104884f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Nov 2026 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212817; x=1794817617; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
        b=oWP+Rohp/ZJqGkQ+oORUcfZmPncX/8Tq39EQaGWxPWIS52HRy425y5lFRzPPC3Chpl
         /R7Jba9ogvC+/fZs6IAAZLC3jvceX5rU0N7ivWgRMFm8SIrKMTFw+1zt0ASAEIaa5JAu
         UiwHcK/EI2ZqUTaK8ufuyQaNuPAmmgTyJ62mcVKWNy4xbc1yJKoEzMxYi1VmdnGuwMKF
         0lpR5fsyxrbB5W39WxkLI46qF1McQOggOviPNfVmhqipl5VHYpLizq1dXBzyHZIs8QOV
         7ekEv63CMreUCjyBhkEpfNMx5f2L/Yxte8iqYzHEvOv2NaGv2E2dLtPqZ4wEAyPxeMF5
         uCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212817; x=1794817617;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IWGbInK1jdqWzqaTB9EgR+W+5CoWAJO2TLJFxQVt21I=;
        b=BXMAqFaNihxS8mer39cve4EhmB6tVXy6vmFx0N5y1K2c6/bcOfmmeXewi39P/nIQVw
         23TEzMe0WWFpVeR/FbLGfE2YHZzyFAEwEnakMhLT7o9RcKmnM9cwban5ajv6rq2TumiP
         CNwmo10GIn42HX+nnIEPbP6PUuW3I9GmOTm29mz+alebxw2XXw5k5o283lM0H87WL03m
         ul79Wg16WNmtPoCJ8Epysl7MNlRA65aq/oGw0rfwraQicCer82sRbB+FCAlyv8tqjGXT
         yjMHXLE0r1m8nAvHwTqTdDbUEFzh0EfKBCXPzWqwAs0ibwuKLe2y91IBW9ybMGLJMMwV
         Z0Bg==
X-Forwarded-Encrypted: i=1; AL+hErGeJD33CZdA0M4V/ArLrgSCD8ZsBJg2l64OO4k6NxG2jpev3h37bJSVHl0ClCk7d5Qtxa32VRh5Bt3DDdjEAg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WCiJJ7iYg2scAI9mTwg+2YO8Wl6r2rAsvO/H5AK2kNVd4B4DZ
	qJppztEVWY+ZDopWzzWZjwTX6MJKxVrxIzqxi8OhYCoxtUSwkTMI7u8a
X-Gm-Gg: AYBFou0uNpiHqvw+hTvPnRTnkYffdhbc0dIgruY1paDDGkSppfiSQOJReLzb6UQy1LY
	lLy1krN3c8GnPoU1yA+0QAfVjzkn8/zEMsIU6amZt3dA9rU8n0Fz6fGURYmXaum3dwD1YRCZLPd
	bhni/Gxup1GzHrxIbYRP7uqVljPAyXNZKOp6gzqmky72o32bHrdoKshqmKvI34dfDq4Ir3knuMs
	FNtLapmg4S/Q8hbGuxZh848F8BGlFrH0B/XUnOaVfL4zN9c/2e66Z9ZII1WqgI3iu+kmCAIDp5V
	gfusUNAv/LqdrG4y+KeUAH0G9v0OiWrWtJuKqxi9IcCOBZdxvdvjHrATnsgv8S+YJQiLeMMCnmf
	NL0lGcpDTJ22KBhlnO8lOvAmFsYTkd2v+yW0DtA8PJuNrM6todrzoUYtzikG8Ze6R67jVHoSuGI
	+R5xlSNKGXOsMLuuTL2a0IqPj7HYtFi1gq2nfujJUr6pTegkvQHEghxpNJq7rYziOQeER6RIl25
	R3RaeEQTCZDTXXdvk1Gp9jZq6Xaov2wiWDTKGrTtlhXsz3R/GcYa9z/0DXTzQS+A76SVTCckAZ4
	eyys/RNdvmlvVk58wtl0U9J+EP++jJooo0z9rIu4ag==
X-Received: by 2002:a05:6000:4b0f:b0:492:dddc:64c3 with SMTP id ffacd0b85a97d-49583deb6d6mr5829208f8f.41.1794212816806;
        Mon, 09 Nov 2026 00:26:56 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm10520949f8f.10.2026.11.09.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:26:56 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 08:26:52 +0000
Subject: [PATCH] watchdog: gunyah_wdt: Re-enable the watchdog on resume
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-gunyah-wdt-resume-v1-1-fbd84545ce92@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMuD8WoC/yXMyw6CMBBG4Vchs3YSWi8JvopxUYZfGBOr6VCEE
 N7dqstvcc5KhqQwOlcrJUxq+owFbleRDCH2YO2Kydf+5FzdcJ/jEgZ+dyMnWH6A/bEN0ogc9gF
 UulfCTeff83L923J7h4zfEW3bB7URElB1AAAA
X-Change-ID: 20261109-gunyah-wdt-resume-25bac9cc43ae
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794212814; l=3385;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=JhBHgp9sr8F6eF0LAjuuKHo+Dq8rxxMvSwyeg83jF/c=;
 b=ql8wh3203NCheD2G7gbJkVZlyVz94Lq19rmDLGGQXmLsGxxXzrNYlSbxL6ypH2s0BQ2gF1EVT
 IX7uthTFwsADMsIVAQSWkq77pwMbZ+82PV+GrQp+s6yAdIRlgcFvv2k
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

gunyah_wdt_suspend() disables an active watchdog, and
gunyah_wdt_resume() enables it again with gunyah_wdt_start(). start()
first disables the watchdog, which fails with -EINVAL when it is
already disabled. start() ignores that only while the watchdog is
inactive, but on resume it is still active for the watchdog core, so
start() returns before it enables the watchdog:

  gunyah-wdt gunyah-wdt: gunyah_wdt_start: Failed to stop gunyah wdt -22

So after every system suspend, the watchdog is left disabled.

Move setting the timeout and enabling the watchdog into
gunyah_wdt_enable(), and call it on resume, where the watchdog is
already disabled.

Tested on the Samsung Galaxy XR (Qualcomm Halliday) with s2idle and
deep suspend.

Fixes: ca316e145c35 ("watchdog: Add driver for Gunyah Watchdog")
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
gunyah_wdt binds on the Samsung Galaxy XR (Qualcomm Halliday) with this
SCM patch:
https://lore.kernel.org/r/20261109-qcom-scm-gunyah-uid-v1-1-2776343f9a3b@gmail.com

This work was made together with Claude.
Reviewed and tested on my Galaxy XR. Without this patch the watchdog
doesn't bite after a suspend. With it, it bites again after both s2idle
and deep suspend.
---
 drivers/watchdog/gunyah_wdt.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/gunyah_wdt.c b/drivers/watchdog/gunyah_wdt.c
index 557a78306d18..348c7ccddde0 100644
--- a/drivers/watchdog/gunyah_wdt.c
+++ b/drivers/watchdog/gunyah_wdt.c
@@ -62,19 +62,12 @@ static int gunyah_wdt_call(unsigned long func_id, unsigned long arg1,
 	return gunyah_error_remap(res.a0);
 }
 
-static int gunyah_wdt_start(struct watchdog_device *wdd)
+static int gunyah_wdt_enable(struct watchdog_device *wdd)
 {
-	unsigned int timeout_ms;
+	unsigned int timeout_ms = wdd->timeout * 1000;
 	struct device *dev = wdd->parent;
 	int ret;
 
-	ret = gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
-	if (ret && watchdog_active(wdd)) {
-		dev_err(dev, "%s: Failed to stop gunyah wdt %d\n", __func__, ret);
-		return ret;
-	}
-
-	timeout_ms = wdd->timeout * 1000;
 	ret = gunyah_wdt_call(GUNYAH_WDT_SET_TIME, timeout_ms, timeout_ms);
 	if (ret) {
 		dev_err(dev, "%s: Failed to set timeout for gunyah wdt %d\n",
@@ -89,6 +82,20 @@ static int gunyah_wdt_start(struct watchdog_device *wdd)
 	return ret;
 }
 
+static int gunyah_wdt_start(struct watchdog_device *wdd)
+{
+	struct device *dev = wdd->parent;
+	int ret;
+
+	ret = gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
+	if (ret && watchdog_active(wdd)) {
+		dev_err(dev, "%s: Failed to stop gunyah wdt %d\n", __func__, ret);
+		return ret;
+	}
+
+	return gunyah_wdt_enable(wdd);
+}
+
 static int gunyah_wdt_stop(struct watchdog_device *wdd)
 {
 	return gunyah_wdt_call(GUNYAH_WDT_CONTROL, WDT_CTRL_DISABLE, 0);
@@ -224,7 +231,7 @@ static int gunyah_wdt_resume(struct device *dev)
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 
 	if (watchdog_active(wdd))
-		gunyah_wdt_start(wdd);
+		gunyah_wdt_enable(wdd);
 
 	return 0;
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261109-gunyah-wdt-resume-25bac9cc43ae

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

