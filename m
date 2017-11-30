Return-Path: <yannick.fertre@st.com>
Return-path: <yannick.fertre@st.com>
From: Yannick FERTRE <yannick.fertre@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "wim@iguana.be"
	<wim@iguana.be>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE
	<alexandre.torgue@st.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: RE: [PATCH v2] watchdog: stm32: Fix copyright
Date: Thu, 30 Nov 2017 09:08:22 +0000
Message-ID: <91ebd76f2d294857a1364de8ac4dfde6@SFHDAG6NODE1.st.com>
References: <20171130084804.23693-1-benjamin.gaignard@st.com>
In-Reply-To: <20171130084804.23693-1-benjamin.gaignard@st.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

-----Original Message-----
From: Benjamin Gaignard [mailto:benjamin.gaignard@linaro.org]=20
Sent: jeudi 30 novembre 2017 09:48
To: wim@iguana.be; linux@roeck-us.net; mcoquelin.stm32@gmail.com; Alexandre=
 TORGUE <alexandre.torgue@st.com>
Cc: linux-watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org; l=
inux-kernel@vger.kernel.org; Benjamin GAIGNARD <benjamin.gaignard@st.com>; =
Yannick FERTRE <yannick.fertre@st.com>
Subject: [PATCH v2] watchdog: stm32: Fix copyright

Uniformize STMicroelectronics copyrights header Add SPDX identifier

Acked-by: Yannick Fertre <yannick.fertre@st.com>

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c =
index be64a8699de3..c97ad5619cb0 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -1,12 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STM32 Independent Watchdog
  *
- * Copyright (C) Yannick Fertre 2017
- * Author: Yannick Fertre <yannick.fertre@st.com>
+ * Copyright (C) STMicroelectronics 2017
+ * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
  *
  * This driver is based on tegra_wdt.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
=20
 #include <linux/clk.h>
--
2.15.0
