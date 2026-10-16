Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D644C4E8
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188991; cv=none; b=G4m027HSXoYw4nAj4HHDbiOkstRPo3tdmVehSOvlfH2Mzy6gNeZS6vKXIqSsq2tedg22Y6TGMedGzJBVU58geFPFP4DdEo3tMgiPZRYlBcRMQeTopM9CTrq9ao4yPudJHa/T+tC1TjjvQxAuqjAXomH/h3lXVlPlnsxQ4NpWYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188991; c=relaxed/simple;
	bh=TXBqsVGg9cAtgaVHRhNDFyJ7mFNE3M7pp6dyhTAsDp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyNUhDd+wEVAbfqPFjcMHcbcA79MjFgi0/oqdyXBJE25kDfxuZHIpk1UWB6UBfh1uBaypcT7nkAtgI7jSbQReR2ESGr1rIfWGJB51YIP/D3Bd39kYBmM8ltz4Iwc3LquYLcmVt+Lap+OgwjU2QvKcyb9L1jMCyhaejdkL1uJAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdpTr6tl; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdpTr6tl"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so395350eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792188989; x=1792793789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RQWVgYSBP0OMtApng4YZ1gHWXM9hb7Ag3kJOb+CrpA=;
        b=CdpTr6tlGv6Dh3hjWO3vxHYfQjRfIFH/aG67epNUmoRlIpOAO5s3rrJQu2v/fjqZe8
         hDo2LvHALk4eLeTOAIdPzPgoMqXFNr1/upY+3Pl+Ql0Bilra+KS3ueCYJtAV6M3XUpFh
         HQnp65AjQ3kj/D8KYtrZU84CWbfTFnsPxMcdiIiLEADz0/BMnllKWJNLojQKKhvD8sXP
         cJaha7QcqNQalSNFY511Ce0AdJcG3BSMtOOQpIC5acZWCFE29AMokpoC4TtKZaJOdCVf
         KifKaDjYT5OGEUHrNK0V/N0xZ/WRg3zkN1DwzSApnmE1amkn7xWIW7G7spHm/JOQKtWO
         mNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188989; x=1792793789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RQWVgYSBP0OMtApng4YZ1gHWXM9hb7Ag3kJOb+CrpA=;
        b=LMwpak7u9O96si9HuK0NtbHI+cCDeYLmeozM4ECRZVno1mflDx+MC/xD7R8E32hHx+
         qB47g56LR+r2z5+Pj5V4NXvKknllwr+wfxrzVc5sjK1kFBynslcB3bxBO2vcwcCJlIvM
         HB2pPcXlsYTYrh8RnD5ssrgRxfcn89G6ROXi+1M85wiDBPTf3FJNgcveyR7Dab42n9h1
         yQB3Yk7I/rIDjWytvPP6MfthWbw+jlf/zCJhFF/bPRB0MNZngrYRPBh8e+IQJnwD2NLi
         Ldo76g/xn1Fe9i7TyUP96t1+vWvPy7myrLqDxmDqZlKCGnFmNcsDjJWVsDsekm3lthOF
         NVlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQgHUNy39Ja/cuTpLbK6LC/BCQxoseQJ/a8oOYWaoTudDP/BtldkbdMFEU8sCbLMJ8XeTfXmKldS5Gi5PwSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLrxqna3iLSqOJ+u2bGj1NTCrYvSZL4xpb2A7ozBoRz3G2icSqe
	1JIMGfFfwUvbIZDi/3co2wGxdWmR+lmwCGa3+0J5tQ2xV5kjPSoAlV+y
X-Gm-Gg: AYBFou260y2og6nGOwFjz8WU0I/LMk7wDdZoBHh8LAO23G3m9DLUR9th6mTer8ui9NB
	uCzfdKaNs33ir2KtOsdNTMnQiRdz5IV7ronSL/pHCW+d34GQmAM+JYOZihEXDX3D11Sn9oywxuR
	PJTu4sCoRGFRvgTWGZ+U3g0+41kOSHXV/HHLSnQ6DZ1vZlQzOUWYiI90S8THTtwQ8fobwEyW1hq
	NqI2ZFctT0PCNx46Q2lBLKeLhEQ72LqYB5NaNlluRiHgjMAVneXhCJEQQ5jl5qcVd06yWB0Mej7
	z6VlVozElgoiPS9cQmdZQjUvV8McDt1rnjRWHdIbsuSFaHUrOAeqYs6/gerOlpHMRdbd3ggS3Za
	vhxX1NYFglIcT6heHm+c8JOqTI2NMXFmlrPNnoRnvu3z0xH2av8LHp157FmnT7JnxwykEB+WP54
	f1ZVqofZ0iNio+VlSTsa7d7OILc+E/plj7pYjPgladR7vayES1rWbeQccM0dwfD2b+9xiRqg4=
X-Received: by 2002:a05:7022:f118:b0:146:85b9:970b with SMTP id a92af1059eb24-18514256f24mr1604037c88.39.1792188989457;
        Fri, 16 Oct 2026 15:16:29 -0700 (PDT)
Received: from eldorado ([2600:8802:b00:1f84:d294:66ff:fe95:a98e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10480863c88.6.2026.10.16.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:16:28 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	manuel.lauss@gmail.com
Subject: [PATCH 4/5] MIPS: Alchemy: Use the GPIO watchdog driver on MTX-1
Date: Fri, 16 Oct 2026 15:16:16 -0700
Message-ID: <20261016221617.2223004-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016221617.2223004-1-f.fainelli@gmail.com>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MTX-1 watchdog is serviced by toggling GPIO 215. Describe its toggle
algorithm and 1.6-second minimum interval through the existing software
node properties, and register gpio-wdt instead of mtx1-wdt.

The nominal 100-second circuit reset the test board about 82 seconds after
starting an unclean-close test over the serial console. Allow for circuit
tolerance and console transmission time with a conservative 70-second
hardware service margin. Keep a 100-second initial userspace timeout and
let the core schedule keepalives for the longer userspace timeout.

Mark the watchdog always-running so the core services it before userspace
opens the device and after a clean stop, without trying to disable the
hardware by tristating the GPIO. Enable GPIO_WATCHDOG in the MTX-1
defconfig.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/alchemy/board-mtx1.c   | 8 +++++++-
 arch/mips/configs/mtx1_defconfig | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 88c20c0ca96d..8543ae42af92 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -125,13 +125,19 @@ static void __init mtx1_keys_init(void)
 }
 
 static const struct property_entry mtx1_wdt_props[] = {
+	PROPERTY_ENTRY_STRING("hw_algo", "toggle"),
+	/* Allow for tolerance in the nominal 100-second timeout. */
+	PROPERTY_ENTRY_U32("hw_margin_ms", 70000),
+	PROPERTY_ENTRY_U32("hw-min-interval-ms", 1600),
+	PROPERTY_ENTRY_U32("timeout-sec", 100),
+	PROPERTY_ENTRY_BOOL("always-running"),
 	/* Global number 215 is offset 15 on Alchemy GPIO 2 */
 	PROPERTY_ENTRY_GPIO("gpios", &alchemy_gpio2_node, 15, GPIO_ACTIVE_HIGH),
 	{ }
 };
 
 static const struct platform_device_info mtx1_wdt_info __initconst = {
-	.name = "mtx1-wdt",
+	.name = "gpio-wdt",
 	.id = 0,
 	.properties = mtx1_wdt_props,
 };
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index e28a0b1e6d52..5e060daded9d 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -377,7 +377,7 @@ CONFIG_SENSORS_W83627HF=m
 CONFIG_SENSORS_W83627EHF=m
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
-CONFIG_WDT_MTX1=y
+CONFIG_GPIO_WATCHDOG=y
 # CONFIG_VGA_ARB is not set
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-- 
2.53.0

