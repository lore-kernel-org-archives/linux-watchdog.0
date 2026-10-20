Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457687;
	b=5pRJ+jq/UPoSq/DjNInnthM5vep0wnInMadi6ieeXxaBZepZXu73C910mNGkIo8WfQss
	 rovEARsFoSMyYnHy4Uojnm59FP80tpurYw4wXnXiG/ODub2YCkSJaQz8NWchc3mvC6P3O
	 wpZnutQ1a2M3RY/5tbZyg9gQdaIzmOsiVzsSeWST58afNHvRSt+T9vmh0TUidyLgYk16I
	 1P54m6KAoapqKBre4b8DluBHe2/lhwHsvHuJcFI51lEoI4ZkLe6KpwG3qsa51sBgMBTEq
	 CiP8EIKUnr55qe52GQ5opPSPMb96fVwPa9pH0/uSd/m1Cz6JGMPaJ2ghvusRoSp+Mkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5L9Ds1PM86X/crynnhDMvakApoTuXbmfA/ZMIvpbCNI=;
	b=bFRroWb3bgdBDbG0CaSmh07HWkY4NRy/tWc1ebXsazjmaRQy0hL08NsK3oyfHKFXPCmy
	 fiajSOgVzFjOeTRtP5hH/o/F0pxguwv8gEz7G/9RKiqZEI7OACoom48TYusXPk8Fvz0Io
	 4VaRujGwUVCgz0rbW1TI0LHIdvuSPpgMfaf+jvnVyXmMSbDsvMFHJUk+R7h3bF7fmKAcW
	 tYjKpbj0oJyhoV5RHL/64jBjRIXvZkQl4gUzp6FkXC864eCuXVIEWBlRt/qvExzwJL/X9
	 Mh6/Ln5Kv1wPVAaewljaoZJ6pIuuDmV4KE7ytSmer1ce1jYIaIHFzomolLMguK3LVAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h+qeGaRC;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DC606A325
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 00:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD9DC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h+qeGaRC
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2028063a91.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 17:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792457686; x=1793062486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5L9Ds1PM86X/crynnhDMvakApoTuXbmfA/ZMIvpbCNI=;
        b=h+qeGaRCcC+WXh7kBip+n7QTpu7vPPu6Qq51pDdMPSkW8UcZEILYMFD+UHY9ehiCJH
         /tO12vo4sePYLU9/1322kWWsgxfKAqrER20J76x/bBHA/lh924J5wn9JER5JRwIxgiFj
         qoPW6tQdzdSGr3xzLelOU33CE+oSAgjdSTw+aMdCMJx4au3BNH+hvEbLvRT70QEAddhk
         gwVwb2M729RWTmdbQLOiZitza0mttyqnxr8dvIbaxIbZpEZRWtaKCwIpxYbSQF3vxdsh
         CvVMF4pOKgU+564hpCYBpOwfEko9LEJ+c03aHvAK0wVAaJxTMmH/UOUfTGDpj0Clte1E
         XD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792457686; x=1793062486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5L9Ds1PM86X/crynnhDMvakApoTuXbmfA/ZMIvpbCNI=;
        b=RSXVLc0Z1WJ0VNVHIzg/ti/mJJ6spn2wMM5/1CyYNcFkMQEkq08WDF6C8k6OWhU8Cr
         cQTwo1gR7LJQaoNfw4y+46Y+Kz7UPLMmQjD6BD+pyWkiuJI8RauYYHvZhzws8QzXzWsb
         mox0Uno+cJ+fSYVIv+BMzk9QwA9V6JkvRfxZKEuDHM8eOKx6Q6W1WPrhoIBL8GY0S4kb
         UnE6yi9Jekc6riKvJYy5gpWEBZTMicDrahF3rW2OHAkuWI4IvY5D7Sll+EgLKB4B0JzS
         HWiq3ne/jxN0OeEnuCJPRKu5wpMpXwVaqa0TkF0DYb4FFKLiWSHhMk2qESF3HZ8NTxCO
         TiSQ==
X-Gm-Message-State: AFq9FYKRi8+gN/yF952AMZkp+DGJN8Gg6BL91fGRK6phc5y53ffpIEHh
	8thwzAhd6vZ2U9OO6gPFoejqDTgv79+eg9NRLnext8MldInWq7/xDRAMWImKxA==
X-Gm-Gg: AYBFou3F85VlA7nTNSnMQbKMKa24ZbDDxrazrQfy+4gHsc/IXxLiBRn083H4gYwa2du
	6vZ1NISk7tiia8dyatg5Hqg4ZxzqdRcY93VpUY0k7OEXzNaVGRZ2ktdrpj1M9lsKc8p2uifd5zV
	MBSyXPWVAubSCH4xPDFDLgpTcvTRILaXwhL/pdj2bDccfDOOSNE+Q3NwBPNP7N1gRkloJQxP8pO
	9DYWyKGLDQjlyYnFO16O41rtiBXcVEm7nnja6aqnkz3o3PW4grQAbmBe2/jLTUqQoWOcLpjbuEc
	SeHGGLP0t9lGsMwHZnWx+mviXB/2E67mhy9urtIziCbUc+AntTVcqvsMch2ewpOFkAKnC7Luyer
	b1UPvUzgln141+BWzfYSnMjIUEAsERfvM8U6o4zFPNpkkBJYKlIBT0ESi3VgrFva/FeWWmk9sAj
	qWZYyEZG0MlALSD8w8zc9nTdvN2pt/fk4DUvUUWtSlIAhSlLCz+R7+xEbQZaofQPpiGrBlD0pye
	Q0HmsyqeD8cdQ==
X-Received: by 2002:a17:90b:560d:b0:3ac:adce:60c2 with SMTP id 98e67ed59e1d1-3acef0ff9b6mr8194015a91.17.1792457686000;
        Mon, 19 Oct 2026 17:54:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df937sm1594543a91.12.2026.10.19.17.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:54:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog updates for v7.4
Date: Mon, 19 Oct 2026 17:54:43 -0700
Message-ID: <20261020005443.555576-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull watchdog updates for Linux v7.4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4

Thanks,
Guenter
------

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.4

for you to fetch changes up to 6276c8195e598361942082423114877265c17692:

  watchdog: mediatek: Apply the driver's mode to a watchdog left running (2026-10-19 17:41:40 -0700)

----------------------------------------------------------------
watchdog updates for v7.4 commit window

* Core/generic

  - Replace __MODULE_STRING() with __stringify()

  - Use assign_bit() where applicable

  - Use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr for dev_pm_ops

  - Fix repeated words and typos in comments

  - Differentiate scenarios when watchdog is closed

* Added device support in existing drivers

  - mtk_wdt: Support for MediaTek MT8167 and MT8127

  - apple_wdt: Support for T8140

  - s3c2410_wdt: Support for Exynos 5515

* Various other minor bug fixes and improvements

----------------------------------------------------------------
Aiden Isik (2):
      dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt compatible
      watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data

Charles Haithcock (1):
      watchdog: Differentiate scenarios when watchdog is closed

Christoph Berliner (1):
      watchdog: sp5100_tco: allow unreserved MMIO on GA-78LMT-USB3

Hemanth Selam (2):
      watchdog: fix typos in comments
      watchdog: fix repeated words in comments

Jan Kiszka (1):
      watchdog: i6300esb: do not stop an already running watchdog

Lad Prabhakar (1):
      dt-bindings: watchdog: renesas,r9a09g057-wdt: Add CPG/MSSR syscon support

Li Jun (3):
      watchdog: sp805: Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
      watchdog: PM: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr for dev_pm_ops
      watchdog: sp805_wdt: fix suspend/resume handling of HW_RUNNING watchdog

Luca Leonardo Scorcia (3):
      watchdog: mediatek: Add wdt/toprgu resets for mt6589
      dt-bindings: watchdog: Add compatible for MediaTek mt8167
      watchdog: mediatek: Add support for mt8167 toprgu/watchdog

Peng Fan (1):
      watchdog: use assign_bit() where applicable

Petr Pavlu (1):
      watchdog: Replace __MODULE_STRING() with __stringify()

Ryan Brue (1):
      watchdog: mediatek: Apply the driver's mode to a watchdog left running

Tzung-Bi Shih (1):
      watchdog: msc313e: Replace commas with semicolons in probe()

Wanming Gao (1):
      watchdog: mediatek: acknowledge pretimeout interrupt

Yureka Lilian (1):
      dt-bindings: watchdog: apple,wdt: Add t8140 compatible

Zakariya Hadrami (1):
      dt-bindings: watchdog: mediatek: Add MT8127

Zexin Wang (1):
      watchdog: sbsa_gwdt: add early_enable module parameter

 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   2 +
 .../bindings/watchdog/renesas,r9a09g057-wdt.yaml   |  29 +++-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |  23 ++-
 Documentation/watchdog/watchdog-parameters.rst     |   2 +
 drivers/watchdog/acquirewdt.c                      |   3 +-
 drivers/watchdog/advantech_ec_wdt.c                |   3 +-
 drivers/watchdog/advantechwdt.c                    |   5 +-
 drivers/watchdog/airoha_wdt.c                      |   5 +-
 drivers/watchdog/alim1535_wdt.c                    |   5 +-
 drivers/watchdog/alim7101_wdt.c                    |   5 +-
 drivers/watchdog/arm_smc_wdt.c                     |   3 +-
 drivers/watchdog/armada_37xx_wdt.c                 |   3 +-
 drivers/watchdog/aspeed_wdt.c                      |   3 +-
 drivers/watchdog/at91rm9200_wdt.c                  |   5 +-
 drivers/watchdog/at91sam9_wdt.c                    |   5 +-
 drivers/watchdog/atcwdt200_wdt.c                   |   5 +-
 drivers/watchdog/ath79_wdt.c                       |   5 +-
 drivers/watchdog/bcm2835_wdt.c                     |   3 +-
 drivers/watchdog/bcm47xx_wdt.c                     |   5 +-
 drivers/watchdog/bcm7038_wdt.c                     |   3 +-
 drivers/watchdog/booke_wdt.c                       |   3 +-
 drivers/watchdog/cadence_wdt.c                     |  13 +-
 drivers/watchdog/cgbc_wdt.c                        |   7 +-
 drivers/watchdog/da9052_wdt.c                      |   5 +-
 drivers/watchdog/da9055_wdt.c                      |   3 +-
 drivers/watchdog/da9062_wdt.c                      |   8 +-
 drivers/watchdog/davinci_wdt.c                     |   7 +-
 drivers/watchdog/db8500_wdt.c                      |   5 +-
 drivers/watchdog/dw_wdt.c                          |   3 +-
 drivers/watchdog/ebc-c384_wdt.c                    |   5 +-
 drivers/watchdog/eurotechwdt.c                     |   3 +-
 drivers/watchdog/exar_wdt.c                        |   5 +-
 drivers/watchdog/f71808e_wdt.c                     |   9 +-
 drivers/watchdog/gef_wdt.c                         |   3 +-
 drivers/watchdog/geodewdt.c                        |   5 +-
 drivers/watchdog/gpio_wdt.c                        |   3 +-
 drivers/watchdog/hpwdt.c                           |   3 +-
 drivers/watchdog/i6300esb.c                        |  28 +++-
 drivers/watchdog/iTCO_wdt.c                        |   5 +-
 drivers/watchdog/ib700wdt.c                        |   5 +-
 drivers/watchdog/ibmasr.c                          |   3 +-
 drivers/watchdog/ie6xx_wdt.c                       |   5 +-
 drivers/watchdog/imgpdc_wdt.c                      |   5 +-
 drivers/watchdog/imx2_wdt.c                        |   5 +-
 drivers/watchdog/imx7ulp_wdt.c                     |   3 +-
 drivers/watchdog/imx_sc_wdt.c                      |   3 +-
 drivers/watchdog/indydog.c                         |   3 +-
 drivers/watchdog/intel_oc_wdt.c                    |   5 +-
 drivers/watchdog/it87_wdt.c                        |   7 +-
 drivers/watchdog/jz4740_wdt.c                      |   7 +-
 drivers/watchdog/keembay_wdt.c                     |  13 +-
 drivers/watchdog/kempld_wdt.c                      |   7 +-
 drivers/watchdog/lenovo_se10_wdt.c                 |   5 +-
 drivers/watchdog/lenovo_se30_wdt.c                 |   5 +-
 drivers/watchdog/lenovo_se30g2_se60_wdt.c          |   5 +-
 drivers/watchdog/loongson1_wdt.c                   |   5 +-
 drivers/watchdog/lpc18xx_wdt.c                     |   5 +-
 drivers/watchdog/ma35d1_wdt.c                      |   3 +-
 drivers/watchdog/max63xx_wdt.c                     |   9 +-
 drivers/watchdog/max77620_wdt.c                    |   3 +-
 drivers/watchdog/mena21_wdt.c                      |   3 +-
 drivers/watchdog/menf21bmc_wdt.c                   |   3 +-
 drivers/watchdog/menz69_wdt.c                      |   3 +-
 drivers/watchdog/meson_gxbb_wdt.c                  |   5 +-
 drivers/watchdog/meson_wdt.c                       |   3 +-
 drivers/watchdog/mixcomwd.c                        |   3 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |   5 +-
 drivers/watchdog/msc313e_wdt.c                     |  12 +-
 drivers/watchdog/mt7621_wdt.c                      |   3 +-
 drivers/watchdog/mtk_wdt.c                         | 162 +++++++++++++++++----
 drivers/watchdog/nct6694_wdt.c                     |   3 +-
 drivers/watchdog/ni903x_wdt.c                      |   5 +-
 drivers/watchdog/nic7018_wdt.c                     |   5 +-
 drivers/watchdog/nv_tco.c                          |   5 +-
 drivers/watchdog/octeon-wdt-main.c                 |   5 +-
 drivers/watchdog/of_xilinx_wdt.c                   |   8 +-
 drivers/watchdog/omap_wdt.c                        |   3 +-
 drivers/watchdog/orion_wdt.c                       |   3 +-
 drivers/watchdog/pc87413_wdt.c                     |   9 +-
 drivers/watchdog/pcwd.c                            |   5 +-
 drivers/watchdog/pcwd_pci.c                        |   7 +-
 drivers/watchdog/pcwd_usb.c                        |   7 +-
 drivers/watchdog/pika_wdt.c                        |   5 +-
 drivers/watchdog/pm8916_wdt.c                      |   8 +-
 drivers/watchdog/pnx4008_wdt.c                     |   5 +-
 drivers/watchdog/pseries-wdt.c                     |   7 +-
 drivers/watchdog/rc32434_wdt.c                     |   5 +-
 drivers/watchdog/renesas_wdt.c                     |   3 +-
 drivers/watchdog/rn5t618_wdt.c                     |   3 +-
 drivers/watchdog/rt2880_wdt.c                      |   3 +-
 drivers/watchdog/rti_wdt.c                         |   5 +-
 drivers/watchdog/rzg2l_wdt.c                       |   3 +-
 drivers/watchdog/rzv2h_wdt.c                       |   3 +-
 drivers/watchdog/s32g_wdt.c                        |   5 +-
 drivers/watchdog/s3c2410_wdt.c                     |  23 ++-
 drivers/watchdog/sama5d4_wdt.c                     |   5 +-
 drivers/watchdog/sbc60xxwdt.c                      |   5 +-
 drivers/watchdog/sbc7240_wdt.c                     |   5 +-
 drivers/watchdog/sbc8360.c                         |   3 +-
 drivers/watchdog/sbc_epx_c3.c                      |   3 +-
 drivers/watchdog/sbsa_gwdt.c                       |  24 ++-
 drivers/watchdog/sc1200wdt.c                       |   3 +-
 drivers/watchdog/sch311x_wdt.c                     |   5 +-
 drivers/watchdog/shwdt.c                           |   7 +-
 drivers/watchdog/simatic-ipc-wdt.c                 |   3 +-
 drivers/watchdog/sl28cpld_wdt.c                    |   3 +-
 drivers/watchdog/smsc37b787_wdt.c                  |   3 +-
 drivers/watchdog/softdog.c                         |   5 +-
 drivers/watchdog/sp5100_tco.c                      |  68 ++++++++-
 drivers/watchdog/sp805_wdt.c                       |  14 +-
 drivers/watchdog/starfive-wdt.c                    |   7 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |  13 +-
 drivers/watchdog/stpmic1_wdt.c                     |   3 +-
 drivers/watchdog/sun4v_wdt.c                       |   5 +-
 drivers/watchdog/sunplus_wdt.c                     |   3 +-
 drivers/watchdog/sunxi_wdt.c                       |   3 +-
 drivers/watchdog/tegra_wdt.c                       |   5 +-
 drivers/watchdog/tqmx86_wdt.c                      |   3 +-
 drivers/watchdog/ts4800_wdt.c                      |   3 +-
 drivers/watchdog/twl4030_wdt.c                     |   3 +-
 drivers/watchdog/txx9wdt.c                         |   7 +-
 drivers/watchdog/uniphier_wdt.c                    |   5 +-
 drivers/watchdog/via_wdt.c                         |   5 +-
 drivers/watchdog/visconti_wdt.c                    |   3 +-
 drivers/watchdog/w83627hf_wdt.c                    |   5 +-
 drivers/watchdog/w83877f_wdt.c                     |   5 +-
 drivers/watchdog/w83977f_wdt.c                     |   5 +-
 drivers/watchdog/wafer5823wdt.c                    |   5 +-
 drivers/watchdog/watchdog_core.c                   |   5 +-
 drivers/watchdog/watchdog_dev.c                    |   9 +-
 drivers/watchdog/wdat_wdt.c                        |   5 +-
 drivers/watchdog/wdt.c                             |   9 +-
 drivers/watchdog/wdt977.c                          |   7 +-
 drivers/watchdog/wdt_pci.c                         |   9 +-
 drivers/watchdog/wm831x_wdt.c                      |   3 +-
 drivers/watchdog/wm8350_wdt.c                      |   3 +-
 drivers/watchdog/xen_wdt.c                         |   5 +-
 drivers/watchdog/xilinx_wwdt.c                     |   5 +-
 drivers/watchdog/ziirave_wdt.c                     |   3 +-
 include/dt-bindings/reset/mediatek,mt8167-wdt.h    |  21 +++
 141 files changed, 713 insertions(+), 317 deletions(-)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h
