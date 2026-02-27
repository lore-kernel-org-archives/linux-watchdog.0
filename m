Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE03290BE;
	Fri, 27 Feb 2026 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177498; cv=none; b=E4TSVd4cFhinw5+EcG1o6AYvqP0gR2oYGC8fBmgvK2+Ht2zU5/YPKlBNkGyp41JZcHG0/Vcw1MChR1obr9Z4vJHvRc2EcktRNG2lhcxptjPfjlkekV3FwzgvjHoWD2AHIidgZ6doZYdc/MnqhUPbgDB7UNzy25HcHA4o975OwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177498; c=relaxed/simple;
	bh=dDaFwFVDAxlGWqUqbdgTb/VkU5CFjGwdHAfU4ODBCtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pUh26aLdD23EbGjgUmCgyQ0Ixg311hpeuzMVh8nNB8U/to8CxgII0IF9P2V8LawLK+bPmMSonMwJ4DC1fy67ois4jUkqff/67EB1wLC9FTLo9KAYpDNZv80LNBYzqWpWJj8tTWZHR54kBseGHt4gKylVwohdsXT8aZulMwaxPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AXN8xjFn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AXN8xjFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772177497; x=1803713497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dDaFwFVDAxlGWqUqbdgTb/VkU5CFjGwdHAfU4ODBCtg=;
  b=AXN8xjFnMDR9Z8fbUgXHS3xFBHFUuNeX7DZDrK1kBz6yrMCeVW4deT+M
   pIo8TFqUiqPV4iACTFKUS+Krb/Icl2SRqQPhQ0hio+gWbCClZNbboWWCx
   pvBHGU7nN/zq8AndF0ldclwT/pjYpn/WdceTKsY9otqvtAKEbzvcH4wcv
   0KFqbCnfMtiUsiSY3PDiaNzKrUrD9r2od8AwaTGguxQLVjqXxKKjqXBg1
   2M9uqhtOFsMmVjpUnsCHkK+zEwsA70pyHGpczCfLm+Hqxh+A/bSVpiTB+
   KxRtHIoMzYvg98yHvcwoZFy5/LkHBUXQJIQ9xBi7nwsKGzA/+CCfJnNvY
   g==;
X-CSE-ConnectionGUID: vpDQk4TsSECHsMOlyQZBaw==
X-CSE-MsgGUID: fgIAV63zSnubCMpkLe64ng==
X-IronPort-AV: E=Sophos;i="6.21,313,1763449200"; 
   d="scan'208";a="221239577"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 00:31:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Feb 2026 00:31:21 -0700
Received: from che-ll-i71840.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 00:31:17 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH 0/3] watchdog: at91/sama5d4: header cleanup and driver refactor
Date: Fri, 27 Feb 2026 13:01:13 +0530
Message-ID: <20260227073116.30447-1-balakrishnan.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series cleans up the AT91 watchdog header and refactors the
sama5d4 watchdog driver.

The header reorganization introduces consistent register naming and
makes the WDDIS bit handling explicit for modern (SAM9X60, SAMA7G5,
SAM9X7) and legacy (SAMA5, AT91SAM9261) SoCs. The driver refactor
improves readability and fixes the reset regression introduced by
commit 266da53c35fc ("watchdog: sama5d4: readout initial state").

Andrei Simion (2):
  watchdog: at91sam9_wdt.h: Cleanup the header file
  watchdog: sama5d4_wdt: Refactor the driver

Balakrishnan Sambath (1):
  watchdog: at91sam9_wdt: Rename AT91_WDT_WDDIS to AT91_WDT_WDDIS_LEGACY

 drivers/watchdog/at91sam9_wdt.c |   8 +-
 drivers/watchdog/at91sam9_wdt.h |  65 +++++++------
 drivers/watchdog/sama5d4_wdt.c  | 156 ++++++++++++++++----------------
 3 files changed, 113 insertions(+), 116 deletions(-)

-- 
2.34.1

