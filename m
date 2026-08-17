Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494213B2FD1
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994862; cv=none; b=Ho1zkRphYTJC/fIVihyc0fh1f8iYbVlVV6w5Cyw5rT+Yc/4QxW7dC5NWYYrk9yA/LeV0+HPVZLTocpT7C7RUrwpFOhoi9OJE0Gz4uKSHFv5PEu7uhE7ociIUkQGdl1HoihY61TfXfe50PPe+dKHpZFHmtRZGlC60BV/d6BJmF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994862; c=relaxed/simple;
	bh=sCRsFH2ldKm//RcRBYjNE96OQfJk0RQOnlx4e2Ail3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ku2aTXynrFBg6Lz4F481J7o3ZEQCkkZGXoKjgobA11FajTddNbpjpkqgselGUQ4Gg4dJYjrE4dRyHUoqeFRGls7kRdVmEFJY2iZ8iC6kk6OTlyTu0tZPiXK/IgpxyZHfaD4Cymc+MrhMCoPlY0wb2Su7+rrhYoG7yiikdsF+rHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J474KgL5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J474KgL5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d032846c95so55118085ad.1
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994861; x=1787599661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2x9DSeWF4J9dYWRG4E5kjbe2yCxFH0E2KZf/UN/jal0=;
        b=J474KgL5izagzVMMOEM3jThgioi0wiKprA5g7IkSjDliHXUfETUSS8otMlDkmZsWLf
         eiUZsq7NiwWuSEJJnx9Fnut8CBvgbqbMEQ5HomDN1bgPfdXOzKNgkc5OBhEkHlEnB5Qw
         /JPhcLC8k7LsNwMp4hwJH7FLYwcYsFUpuc4zuIAX9AiA/4b78Gl5kSL9TnNF0cWhfKRP
         HYgigxtFWBFB7HCBzw0LZqRw/YpysNaNFswsqtvi9CsJqrbL46pJ9C3kogfPTq05paHg
         VXIuSvLcY7s/rn57fXkEkrmPpEA/W8k/lHUqhRgmkxbhZNP1pRzvUyR38SCBDTI7ks8L
         kwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994861; x=1787599661;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2x9DSeWF4J9dYWRG4E5kjbe2yCxFH0E2KZf/UN/jal0=;
        b=paLduinPBR9ngNIvchNvHq1DRszFcTd1s3+SF0JIpDbv5p9FyKOuikXAh3NzD9HlG2
         V+grBoMexZP1kagaDtZ9E+fUvD5d5xtDcP7AmsOnQaBlKH0+RHj2h4OkKVzHG84MbiNn
         rYZpOMBLEtMfrM2EfoyFP7QDeaupmNs1oNoV4703VXPC0mMD2ONw8Q2k4/oroAJNFWS6
         riM+8rvlHt0Kg5YXIn4ZMxNEOwsHdtG3L7nsZaugu3rnPlQU31C9aLZ6RH5UoyLuJe/z
         t/BtbbtkGhT635YFNWzbfwdhqC4T+PVTk1BDh7XC2Tb5tW0TLa89pHr1YtaL1eEnvqWS
         jM0w==
X-Gm-Message-State: AOJu0YzBfXaPrDE2bvW8Qw1neLa7px0viKZK3UcnX55frlcdaVseiT92
	dhj84mK1O7SH6zKlR+i5Wl0tSAHY0M5ez3ezhoVHcJeyFtwfPLREWiV8t9s7wQ==
X-Gm-Gg: AR+sD121BGOSbAbzhY69iXvgK0Wp+kudseooUdHaUnFiKQ7bQR85nAG8VUWnpyYDhpC
	uX/iQqy2MRaLblMxX3XMfoF0Ht2rHctUYWDtnwDo5jppRi+PGgrzna3X4U8pRI7am2yadOO8QVa
	cRRXQWyA0q3vlUlOsuaD6N/Gu70o0JCKEXqw7JCgpnzQjbvaLIBI7fb3+5eY9y9Vp61YQteO8Vb
	6oJu037liWXhXUgukkQ3FQNvWuF8UHdLP9PMTURwgv2cenxg5AVkLu/CsyqJk0WBUppbkEKnzn7
	fjd+fgMbEc+AwcvisFJGbCXSzt9XwyxOC1wSmnN7E7mN776NjN1dvMX7CtAS+8ZLSdkbeAtUWpD
	RAgendCfjnjJjpFKLjhAHym8hNIRsFhbJg4T/JxscJdG/3fLL1wWFM61mL2p2fGmyTxVJKC8GAR
	eJ+7Adn/xNXD2NGmuETfPvE/CfWuUtDhzyJCNBTPxbHROBz9AWTxUrNtLzOu9s5f61NKNVyixD/
	w==
X-Received: by 2002:a17:902:f549:b0:2d5:c0c9:e365 with SMTP id d9443c01a7336-2d5c4f07e25mr26263525ad.3.1786994860729;
        Mon, 17 Aug 2026 12:27:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dcedf4sm8553613eec.5.2026.08.17.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:27:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog updates for v7.3
Date: Mon, 17 Aug 2026 12:27:37 -0700
Message-ID: <20260817192738.897998-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull watchdog updates for Linux v7.3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3

Thanks,
Guenter
------

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.3

for you to fetch changes up to 3bbbeb7fddf54a7d7116b2defe0a63a9b583c84e:

  watchdog: orion_wdt: Propagate errors from optional IRQ lookup (2026-08-10 09:00:05 -0700)

----------------------------------------------------------------
watchdog updates for v7.3

* New Drivers

  - Nuvoton MA35D1

  - Lenovo SE30G2 and SE60

* Added support to existing drivers

  - snps,dw-wdt: Add RV1106 compatible

  - apple,wdt: Add t6030, t6031, and t8132 compatibles

* Other notable changes

  - New "dump" pretimeout governor

  - Propagate errors from optional IRQ lookup

  - Remove redundant dev_err() and dev_err_probe() messages

  - npcm, qcom: Improved bootstatus reports

  - realtek-otto: Change to use regmap API

  - w83627hf_wdt: Report running watchdog, identify NCT6126

* Various other minor fixes and improvements

----------------------------------------------------------------
Babanpreet Singh (1):
      watchdog: booke_wdt: Document unused parameter of __booke_wdt_disable()

Christophe JAILLET (1):
      watchdog: apple: Constify some structures

Janne Grunau (1):
      dt-bindings: watchdog: apple,wdt: Add t6030 and t6031 compatibles

Jingyi Wang (1):
      dt-bindings: watchdog: Document Qualcomm Maili watchdog

Kathiravan Thirumoorthy (2):
      watchdog: qcom: report WDIOF_POWERUNDER in bootstatus
      watchdog: qcom: report bootstatus on IPQ9574 and IPQ5332

Mark Pearson (1):
      watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60

Mayank Rungta (2):
      nmi: Export CPU backtrace APIs for loadable modules
      watchdog: pretimeout: Convert dump pretimeout governor to tristate

Pan Chuang (9):
      watchdog: bd96801_wdt: Remove redundant dev_err_probe()
      watchdog: cadence_wdt: Remove redundant dev_err()
      watchdog: intel-mid_wdt: Remove redundant dev_err()
      watchdog: keembay: Remove redundant dev_err_probe()
      watchdog: marvell_gti: Remove redundant dev_err_probe()
      watchdog: orion: Remove redundant dev_err()
      watchdog: realtek_otto: Remove redundant dev_err_probe()
      watchdog: sama5d4: Remove redundant dev_err()
      watchdog: sprd: Remove redundant dev_err()

Paul Louvel (3):
      watchdog: w83627hf_wdt: Correctly identify Nuvoton NCT6126 chip
      watchdog: w83627hf_wdt: Report the probed chip name via WDIOC_GETSUPPORT
      watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for running chip on boot

Pengpeng Hou (1):
      watchdog: via_wdt: add missing MODULE_DEVICE_TABLE()

Rasmus Villemoes (1):
      watchdog: take all OF aliases into account when assigning id

Renê de Souza Pinto (1):
      watchdog: wdat_wdt: map registers that fall inside ACPI NVS

Rustam Adilov (1):
      watchdog: realtek-otto: Change to use regmap API

Simon Glass (1):
      dt-bindings: watchdog: snps,dw-wdt: Add RV1106 compatible

Tomer Maimon (3):
      dt-bindings: watchdog: npcm: add GCR syscon property
      docs: watchdog: npcm: Add reset status description
      watchdog: npcm: add bootstatus support

Tzung-Bi Shih (1):
      watchdog: pretimeout: Add "dump" pretimeout governor

Uwe Kleine-König (The Capable Hub) (1):
      watchdog: Use named initializers for platform_device_id arrays

Yureka Lilian (1):
      dt-bindings: watchdog: apple,wdt: Add t8132 compatible

Zi-Yu Chen (2):
      dt-bindings: watchdog: Add MA35D1 Watchdog
      watchdog: Add Nuvoton MA35D1 watchdog driver support

bui duc phuc (6):
      watchdog: mediatek: Propagate errors from optional IRQ lookup
      watchdog: dw_wdt: Propagate errors from optional IRQ lookup
      watchdog: stm32_iwdg: Propagate errors from optional IRQ lookup
      watchdog: aspeed: Propagate errors from optional IRQ lookup
      watchdog: qcom: Propagate errors from optional IRQ lookup
      watchdog: orion_wdt: Propagate errors from optional IRQ lookup

 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   3 +
 .../bindings/watchdog/nuvoton,ma35d1-wdt.yaml      |  55 ++++
 .../bindings/watchdog/nuvoton,npcm750-wdt.yaml     |  14 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |   1 +
 Documentation/watchdog/index.rst                   |   1 +
 Documentation/watchdog/npcm_wdt.rst                |  71 ++++
 drivers/watchdog/Kconfig                           |  42 ++-
 drivers/watchdog/Makefile                          |   3 +
 drivers/watchdog/apple_wdt.c                       |   4 +-
 drivers/watchdog/aspeed_wdt.c                      |   2 +
 drivers/watchdog/bd96801_wdt.c                     |   3 +-
 drivers/watchdog/booke_wdt.c                       |   1 +
 drivers/watchdog/cadence_wdt.c                     |   6 +-
 drivers/watchdog/cros_ec_wdt.c                     |   4 +-
 drivers/watchdog/dw_wdt.c                          |   2 +-
 drivers/watchdog/intel-mid_wdt.c                   |   4 +-
 drivers/watchdog/keembay_wdt.c                     |   4 +-
 drivers/watchdog/lenovo_se30g2_se60_wdt.c          | 289 ++++++++++++++++
 drivers/watchdog/ma35d1_wdt.c                      | 363 +++++++++++++++++++++
 drivers/watchdog/marvell_gti_wdt.c                 |   2 +-
 drivers/watchdog/max63xx_wdt.c                     |  14 +-
 drivers/watchdog/max77620_wdt.c                    |   6 +-
 drivers/watchdog/mtk_wdt.c                         |   4 +-
 drivers/watchdog/npcm_wdt.c                        | 217 +++++++++++-
 drivers/watchdog/orion_wdt.c                       |  16 +-
 drivers/watchdog/pretimeout_dump.c                 |  45 +++
 drivers/watchdog/qcom-wdt.c                        |  55 +++-
 drivers/watchdog/realtek_otto_wdt.c                |  76 ++---
 drivers/watchdog/sama5d4_wdt.c                     |   4 +-
 drivers/watchdog/sprd_wdt.c                        |   4 +-
 drivers/watchdog/stm32_iwdg.c                      |   5 +-
 drivers/watchdog/via_wdt.c                         |   1 +
 drivers/watchdog/w83627hf_wdt.c                    |  22 +-
 drivers/watchdog/watchdog_core.c                   |  26 +-
 drivers/watchdog/watchdog_pretimeout.h             |   4 +-
 drivers/watchdog/wdat_wdt.c                        |  27 +-
 include/linux/nmi.h                                |  10 +-
 lib/nmi_backtrace.c                                |   7 +
 39 files changed, 1303 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,ma35d1-wdt.yaml
 create mode 100644 Documentation/watchdog/npcm_wdt.rst
 create mode 100644 drivers/watchdog/lenovo_se30g2_se60_wdt.c
 create mode 100644 drivers/watchdog/ma35d1_wdt.c
 create mode 100644 drivers/watchdog/pretimeout_dump.c
