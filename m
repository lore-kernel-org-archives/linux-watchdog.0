Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4B310625;
	Mon, 16 Feb 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.87.125.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771251783; cv=none; b=Jj7QW0/OQXWNmE64FsMBGjDOoReMqfGkxc9tsRvpgzMKmyFYLuHf4i4XKeQFCAT5XkxJ2uktcU/zFhwrE4Lboof1fX3o2A7LLQC/rHrYPm7KAiWXgb+2XvHy0L9DtBnT0buTHbZZH9H5JH9tr+BkkkwGTNVZx82bShV1R6dgvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771251783; c=relaxed/simple;
	bh=nQbIxEDR4AWrsUb6xTuewxzOttMdNTWbFcshs7yP8y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ml1/L3DKwkEkkj2mMZw3Empl+nr6MJyOx6598AB5ToX77lBT0IQJ+BtUCT/cgIsFH4mi4WFKkh6EvgYyC4wHD8+0mra2cAT/8T9SG+zzGICQLdKRX7q9/W59yKJ7ULwvAIgMyred54dyPFGzOdMwGnzzvLJ3BD/Ml/TGWH//010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org; spf=pass smtp.mailfrom=linux-watchdog.org; dkim=pass (2048-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b=gOKa8EDc; arc=none smtp.client-ip=185.87.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="gOKa8EDc"
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id 7705A40A00; Mon, 16 Feb 2026 14:20:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 7705A40A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20250313; t=1771248051;
	bh=nQbIxEDR4AWrsUb6xTuewxzOttMdNTWbFcshs7yP8y4=;
	h=Date:From:To:Cc:Subject:From;
	b=gOKa8EDc42nl3Q0GQU17YXgU7CJBwY+hwTvszqLtG02PX8jISnoROMbeF5VlYwv+g
	 XGST958OJIDTqCHHVbbzN3SmKAEb8h7S2tG/DpOz+XqitPH5PXcEqKMZXDP8uEedhw
	 Bq8kiTxcGdUebO2QPMNCSF1e4gMA9TyniN0UWMjTYTpgB9ltf2N1FE5qCdPXF0NWse
	 zUtCMhUbBQEBFL9wZSaA2rqc27ohf+RMY8xjDQkRMLIyGhib85iHCP1+OvrCWouuLd
	 K+ZvP/LHirz7F1jB+VhjT/pUg6CRlD4KEw3nTx8xKHPG/DJdzl2oRHYMAlMXD5vbPZ
	 LeeR6VdWFk6pQ==
Date: Mon, 16 Feb 2026 14:20:51 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Kari Argillander <kari.argillander@gmail.com>,
	Kery Qi <qikeyu2017@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Naina Mehta <naina.mehta@oss.qualcomm.com>,
	Oleksandr Suvorov <cryosay@gmail.com>,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Subject: [GIT PULL REQUEST] watchdog - v6.20 release cycle.
Message-ID: <20260216132051.GA30445@www.linux-watchdog.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi Linus,

Please pull following watchdog changes for the v6.20 release cycle.

This series contains:
* iTCO: Drop vendor support
* s3c2410_wdt: Drop S3C2410 support
* Convert mpc8xxx-wdt to YAML
* Several small fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.20-rc1

for you to fetch changes up to 450517fa5aae98b857c68743fd12ce93e4b8989d:

  dt-bindings: watchdog: qcom-wdt: Document Glymur watchdog (2026-01-18 10:59:39 +0100)

----------------------------------------------------------------
linux-watchdog 6.20-rc1 tag

----------------------------------------------------------------
Guenter Roeck (2):
      watchdog: iTCO: Drop vendor support
      watchdog: Always return time left until watchdog times out

J. Neuschäfer (1):
      dt-bindings: watchdog: Convert mpc8xxx-wdt to YAML

Kari Argillander (1):
      watchdog: Make API functions const correct

Kery Qi (1):
      watchdog: starfive-wdt: Fix PM reference leak in probe error path

Krzysztof Kozlowski (4):
      dt-bindings: watchdog: samsung-wdt: Define cluster constraints top-level
      watchdog: s3c2410_wdt: Drop S3C2410 support
      dt-bindings: watchdog: samsung-wdt: Drop S3C2410
      dt-bindings: watchdog: samsung-wdt: Split if:then: and constrain more

Naina Mehta (1):
      watchdog: sbsa: Update the W_IIDR Implementer bit mask to 0xFFF

Oleksandr Suvorov (1):
      watchdog: imx7ulp_wdt: handle the nowayout option

Pankaj Patil (1):
      dt-bindings: watchdog: qcom-wdt: Document Glymur watchdog

Rafael J. Wysocki (2):
      watchdog: rz: Discard pm_runtime_put() return values
      watchdog: rzv2h_wdt: Discard pm_runtime_put() return value

René Rebe (1):
      fix it87_wdt early reboot by reporting running timer

 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   |  25 ---
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.yaml  |  64 ++++++
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |  56 ++++--
 Documentation/watchdog/watchdog-kernel-api.rst     |   2 +-
 Documentation/watchdog/watchdog-parameters.rst     |   7 -
 drivers/watchdog/Kconfig                           |   8 -
 drivers/watchdog/Makefile                          |   3 -
 drivers/watchdog/iTCO_vendor.h                     |  14 --
 drivers/watchdog/iTCO_vendor_support.c             | 216 ---------------------
 drivers/watchdog/iTCO_wdt.c                        |  12 +-
 drivers/watchdog/imx7ulp_wdt.c                     |   1 +
 drivers/watchdog/it87_wdt.c                        |  12 ++
 drivers/watchdog/rzg2l_wdt.c                       |   4 +-
 drivers/watchdog/rzv2h_wdt.c                       |   8 +-
 drivers/watchdog/s3c2410_wdt.c                     |  22 +--
 drivers/watchdog/sbsa_gwdt.c                       |   4 +-
 drivers/watchdog/starfive-wdt.c                    |   2 +-
 drivers/watchdog/watchdog_core.c                   |   3 +-
 drivers/watchdog/watchdog_dev.c                    |  35 ++--
 include/linux/watchdog.h                           |  12 +-
 21 files changed, 156 insertions(+), 355 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.yaml
 delete mode 100644 drivers/watchdog/iTCO_vendor.h
 delete mode 100644 drivers/watchdog/iTCO_vendor_support.c
----------------------------------------------------------------

Kind regards,
Wim.

