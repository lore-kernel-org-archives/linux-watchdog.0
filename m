Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDE3F44FC
	for <linux-watchdog@vger.kernel.org>; Mon, 15 Jun 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532349; cv=none; b=P4cdeRYZH+Fd5JC4UQWyY44uq2Cq+gwFGAs1uXanhLC6luccEorV551cnemo7Vj/bgMvrm40M0sumvICx8FWUPSqZDe0sL0L5IggwJ9VTCzG/GHAfEaTU0NMAjuvX/uyc460Osrfw31nU/EkhM4SaCCDcSSLaYB/EUFVnVeD4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532349; c=relaxed/simple;
	bh=m+rdwtGNwzQ+mq4Pc9XaLXouoayMEvI8vhFL2b/WHJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehDZ1zHJy3bJd4Pj5CBL99YLFkbgJ+BRgrQo57QHViIaIMpPgURgRlfBVk2FhY/05BbBLMJ8uMJJPU+VcUq5eh4xsj2OTef63OtEESGFyGhurlhBh6tgL/MPK4vza/jPus9ZpVDKzgo1ZHBTjQpiLYxNZVYCdZWR+llJS6je5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkqVuPZU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkqVuPZU"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c858d69bde9so1283750a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 15 Jun 2026 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532347; x=1782137147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0JbGL4AUHbB4sqzU6Tl1yIe92g2tI+Aht/u8nw6orKs=;
        b=IkqVuPZUvp9c4MjMJCu3qWQl/0lqVK6kGKeMD5zqHbezxDm5WZK4nCH1Ev/f4+CeON
         g930XYDwUoVbsHXxdgMlE9ZYSH/iGto+zmBGA+nLqgCeY8c4ffpBJHZCRSSkMwusI+Pd
         GWRk7yTuUHWxtpUdectZgMcA87eWTtMu2XH+6akRd5smopDW8sGcgsrDQ+ZSVZA3ngKa
         HEpeuIZI6vKqmGEnNnv4M1phSoNyM3DLeGBg65JWoiAbWyTSa3veJ0mh1jWWbFdR17Z/
         RqyoWJdPHIEUfyrvBC08GzmVWGwezt8RMS3JjBlr6m4qAvdYzprJCqrstLFD8sjq9NyN
         hwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532347; x=1782137147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JbGL4AUHbB4sqzU6Tl1yIe92g2tI+Aht/u8nw6orKs=;
        b=QNHnULzRoD2hO72zhhdDVu2BFTLD+JOys/SMBoPexJkJ9h1GqkwsELfY75sgznzq1m
         /ylySKljAJmWOIKspmO/kHhHMz3GGHxELD169YJTqzCTSCNub416hnZkAA8T1SoPJLJq
         7kd5DxSrfUe54d2HgYgQa6bNu58xFVvB84JfE6i8jHEGXQhDSj2Z4KPR/ClUOm5UhSbG
         OZKJTeNjloXvMb0263vEceWgwdXfYXN4QaHnA14zt15ZBKhQF8APwvau+F2WX6qiuzN7
         aXDGhGa0WvDDd9QVumdO/Q6SpcNMxfviXpoz3NVmJm4PFm4gBVnblP/843E7Giqom8QS
         bIoA==
X-Gm-Message-State: AOJu0Yy74tUab1SzW3R5RiY9HO3biX/pOwYMehcUcCLciKtlaRgTdXvt
	Zx01/lRm4S5oPfL99vb7iT93MHtQkFRS7rhX1QsVGoz2Xw+sCdQLReWS4Vn8QXZR
X-Gm-Gg: Acq92OGR53rCxKI6/yww1HClQhAjAZZDXImXIWlBPe3D4cW+qnjm63d7vymmPljhtlF
	W2toI8F97o8tsqLh2w1lYRrIv/DL2TkNEFnOsx3o0ZdLDHKLWJiEwhXg8JYXoW8cWLDoNMx0jwy
	iitSvxJSzcI+G/yTrZBsepKKbNtnO/u21rLG9Ia7edc4Z3AQtOb/v5C2AQsNxK9W7sfLwvuynBe
	tYY7c0AYL7sDziB7LUrbWqZCw/fPOA12eZS4JSjPb/G4nKUUjGuSGyLVBNPyU7IYEPXHIylRsli
	/H0YjfBufjDXHAzzqeqeCNXHu0CTkNWTKf+6X2EKELHbTMypYfgnp1UtX6TawTcv69JF3nfKJVx
	bNJPqhU+kNAiROSqCpzM4tvVTUMfW5Qtzc3Xob7c5+iy5mYIAEr+ugj0A7Yfd0cpmMV0oU6grRo
	cdpTIGXq6es08HPOWreNHLQDM+ED0KLM7qHB0I
X-Received: by 2002:a05:6a21:6f88:b0:3b3:10e1:a870 with SMTP id adf61e73a8af0-3b783ffa865mr18191989637.32.1781532347419;
        Mon, 15 Jun 2026 07:05:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d1d3sm8888351a12.11.2026.06.15.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:05:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog updates for v7.2
Date: Mon, 15 Jun 2026 07:05:44 -0700
Message-ID: <20260615140545.1954844-1-linux@roeck-us.net>
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

Please pull watchdog updates for Linux v7.2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2

Thanks,
Guenter
------

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.2

for you to fetch changes up to 54c726fbb53341a2553bf234d519d0cb22a2ce3d:

  watchdog: sc1200: Drop unused assignment of pnp_device_id driver data (2026-06-10 06:09:45 -0700)

----------------------------------------------------------------
watchdog updates and fixes for v7.2

* subsystem

- Unregister PM notifier on watchdog unregister

- Various documentation fixes and improvements

* Removed drivers

- Remove AMD Elan SC520 processor watchdog driver
- Drop SMARC-sAM67 support
- Remove driver for integrated WDT of ZFx86 486-based SoC

* New drivers

- Driver for Andes ATCWDT200

- Driver for Gunyah Watchdog

* Added support to existing drivers

- Add "apple,t8103-wdt" and "apple,t8122-wdt" compatibles to Apple
  watchdog driver

- Add rockchip,rk3528-wdt and rockchip,rv1103b-wdt to snps,dw-wdt.yaml

- Document IPQ9650, IPQ5210, Shikra, Nord, and Hawi in qcom-wdt.yaml
  Also document sram property and add support to get the bootstatus
  to qcom wdt driver

- lenovo_se10_wdt: Fix use-after-rfree and add support for SE10 Gen 2
  platform

- ti,rti-wdt: Add ti,am62l-rti-wdt compatible

- renesas: Document RZ/G3L support and rework example for
  renesas,r9a09g057-wdt

* Other bug fixes and improvements

- Use named initializers (sc1200, ziirave_wdt)

- Allow pic32-dmt and pic32-wdt to be built with COMPILE_TEST

- realtek-otto: enable clock before using I/O, and prevent PHASE2 underflows

- rti_wdt: Add reaction control

- renesas,rzn1-wdt: Drop interrupt support and other cleanup

- gpio_wdt: Add ACPI support

- imx7ulp_wdt: Keep WDOG running until A55 enters WFI on i.MX94

- sprd_wdt: Remove redundant sprd_wdt_disable() on register failure

- bcm2835_wdt: Switch to new sys-off handler API

- sama5d4_wdt: Fix WDDIS detection on SAM9X60 and SAMA7G5

- hpwdt: Refine hpwdt message for UV platform

- Convert TS-4800 bindings to DT schema

- menz069_wdt: drop unneeded MODULE_ALIAS

- sp5100_tco: Use EFCH MMIO for newer Hygon FCH

----------------------------------------------------------------
Andrew Davis (1):
      watchdog: bcm2835_wdt: Switch to new sys-off handler API

Balakrishnan Sambath (2):
      watchdog: sama5d4_wdt: Fix WDDIS detection on SAM9X60 and SAMA7G5
      watchdog: at91sam9_wdt.h: Document WDDIS bit position per SoC family

Bartosz Golaszewski (1):
      watchdog: convert the Kconfig dependency on OF_GPIO to OF

Biju Das (1):
      dt-bindings: watchdog: renesas,wdt: Document RZ/G3L support

Brian Masney (2):
      watchdog: pic32-wdt: allow driver to be compiled on all architectures with COMPILE_TEST
      watchdog: pic32-dmt: allow driver to be compiled on all architectures with COMPILE_TEST

CL Wang (3):
      dt-bindings: watchdog: Add support for Andes ATCWDT200
      watchdog: atcwdt200: Add driver for Andes ATCWDT200
      MAINTAINERS: Add entry for Andes ATCWDT200

Deepti Jaggi (1):
      dt-bindings: watchdog: qcom-wdt: Add compatible for Nord watchdog

Eduard Bostina (1):
      dt-bindings: watchdog: Convert TS-4800 to DT schema

Ethan Nelson-Moore (1):
      watchdog: remove driver for integrated WDT of ZFx86 486-based SoC

Fabio Estevam (1):
      dt-bindings: watchdog: rockchip: Add RV1103B compatible

Fabrizio Castro (1):
      dt-bindings: watchdog: renesas,r9a09g057-wdt: Rework example

Felix Gu (1):
      watchdog: sprd_wdt: Remove redundant sprd_wdt_disable() on register failure

Flavio Suligoi (1):
      watchdog: gpio_wdt: add ACPI support

Guenter Roeck (1):
      watchdog: Remove AMD Elan SC520 processor watchdog driver

Herve Codina (Schneider Electric) (2):
      watchdog: rzn1: Use dev_err_probe()
      watchdog: rzn1: Fix reverse xmas tree declaration

Hrishabh Rajput (1):
      watchdog: Add driver for Gunyah Watchdog

Janne Grunau (2):
      watchdog: apple: Add "apple,t8103-wdt" compatible
      dt-bindings: watchdog: apple,wdt: Add t8122 compatible

Jonas Karlman (1):
      dt-bindings: watchdog: Add watchdog compatible for RK3528

Jose Javier Rodriguez Barbarin (1):
      watchdog: menz069_wdt: drop unneeded MODULE_ALIAS

Judith Mendez (2):
      dt-bindings: watchdog: ti,rti-wdt: Add ti,am62l-rti-wdt compatible
      watchdog: rti_wdt: Add reaction control

Kathiravan Thirumoorthy (4):
      dt-bindings: watchdog: qcom-wdt: Document sram property
      watchdog: qcom: add support to get the bootstatus from IMEM
      dt-bindings: watchdog: qcom-wdt: Document IPQ9650 watchdog
      dt-bindings: watchdog: qcom-wdt: Document IPQ5210 watchdog

Komal Bajaj (1):
      dt-bindings: watchdog: qcom-wdt: Document Shikra watchdog

Krzysztof Kozlowski (1):
      watchdog: qcom: Unify user-visible "Qualcomm" name

Mark Pearson (2):
      watchdog: lenovo_se10_wdt: Add support for SE10 Gen 2 platform
      watchdog: lenovo_se10_wdt: Fix use-after-free and resource leak risk

Michael Walle (1):
      dt-bindings: watchdog: Drop SMARC-sAM67 support

Mukesh Ojha (1):
      dt-bindings: watchdog: qcom-wdt: Document Hawi watchdog compatible

Philipp Hahn (5):
      watchdog: Change suffix .txt to .rst in references
      watchdog: Move `struct` before name
      watchdog: Replace intermixed tab/space indent
      watchdog: Separate kind of documentation
      watchdog: Prefix WDT with ICS for clarity

Randy Dunlap (5):
      watchdog: add devm_watchdog_register_device() to watchdog-kernel-api
      watchdog: linux/watchdog.h: repair kernel-doc comments
      watchdog: uapi: add comments for what bit masks apply to
      watchdog: core: clean up some comments
      watchdog: dev: convert to kernel-doc comments

Ranjani Vaidyanathan (1):
      watchdog: imx7ulp_wdt: Keep WDOG running until A55 enters WFI on i.MX94

Sander Vanheule (2):
      watchdog: realtek-otto: prevent PHASE2 underflows
      watchdog: realtek-otto: enable clock before using I/O

Shubham Chakraborty (1):
      docs: watchdog: explain watchdog API options

Steve Wahl (1):
      watchdog/hpwdt: Refine hpwdt message for UV platform

Uwe Kleine-König (The Capable Hub) (2):
      watchdog: ziirave_wdt: Use named initializers for struct i2c_device_id
      watchdog: sc1200: Drop unused assignment of pnp_device_id driver data

Wolfram Sang (2):
      watchdog: rzn1: remove now obsolete interrupt support
      dt-bindings: watchdog: renesas,rzn1-wdt: interrupts are not required

Yingjie Gao (1):
      watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH

Yuho Choi (1):
      watchdog: unregister PM notifier on watchdog unregister

 .../bindings/watchdog/andestech,ae350-wdt.yaml     |  53 ++
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   4 +-
 .../bindings/watchdog/kontron,sl28cpld-wdt.yaml    |   7 +-
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  11 +
 .../bindings/watchdog/renesas,r9a09g057-wdt.yaml   |   8 +-
 .../bindings/watchdog/renesas,rzg2l-wdt.yaml       |   1 +
 .../bindings/watchdog/renesas,rzn1-wdt.yaml        |   1 -
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |   2 +
 .../bindings/watchdog/technologic,ts4800-wdt.yaml  |  40 ++
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |   1 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  25 -
 .../watchdog/convert_drivers_to_kernel_api.rst     |  28 +-
 Documentation/watchdog/{wdt.rst => ics-wdt.rst}    |   8 +-
 Documentation/watchdog/index.rst                   |  20 +-
 Documentation/watchdog/watchdog-api.rst            |  15 +-
 Documentation/watchdog/watchdog-kernel-api.rst     |  10 +-
 Documentation/watchdog/watchdog-parameters.rst     |  19 -
 MAINTAINERS                                        |   7 +
 drivers/watchdog/Kconfig                           |  68 ++-
 drivers/watchdog/Makefile                          |   4 +-
 drivers/watchdog/apple_wdt.c                       |   1 +
 drivers/watchdog/at91sam9_wdt.h                    |   6 +-
 drivers/watchdog/atcwdt200_wdt.c                   | 580 +++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                     |  28 +-
 drivers/watchdog/gunyah_wdt.c                      | 261 ++++++++++
 drivers/watchdog/hpwdt.c                           |  22 +-
 drivers/watchdog/imx7ulp_wdt.c                     |  10 +-
 drivers/watchdog/lenovo_se10_wdt.c                 |  82 ++-
 drivers/watchdog/machzwd.c                         | 452 ----------------
 drivers/watchdog/menz69_wdt.c                      |   1 -
 drivers/watchdog/qcom-wdt.c                        |  42 +-
 drivers/watchdog/realtek_otto_wdt.c                |  20 +-
 drivers/watchdog/rti_wdt.c                         |  39 +-
 drivers/watchdog/rzn1_wdt.c                        |  35 +-
 drivers/watchdog/sama5d4_wdt.c                     |  48 +-
 drivers/watchdog/sc1200wdt.c                       |   4 +-
 drivers/watchdog/sc520_wdt.c                       | 430 ---------------
 drivers/watchdog/smsc37b787_wdt.c                  |   2 +-
 drivers/watchdog/sp5100_tco.c                      |   3 +-
 drivers/watchdog/sprd_wdt.c                        |   5 +-
 drivers/watchdog/watchdog_core.c                   |  15 +-
 drivers/watchdog/watchdog_dev.c                    |  30 +-
 drivers/watchdog/ziirave_wdt.c                     |   2 +-
 include/linux/watchdog.h                           |   8 +-
 include/uapi/linux/watchdog.h                      |   2 +
 45 files changed, 1312 insertions(+), 1148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
 rename Documentation/watchdog/{wdt.rst => ics-wdt.rst} (91%)
 create mode 100644 drivers/watchdog/atcwdt200_wdt.c
 create mode 100644 drivers/watchdog/gunyah_wdt.c
 delete mode 100644 drivers/watchdog/machzwd.c
 delete mode 100644 drivers/watchdog/sc520_wdt.c
