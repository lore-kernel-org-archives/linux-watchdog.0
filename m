Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920E3A168B;
	Tue, 10 Mar 2026 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163986; cv=none; b=hkpUHsQywCcpw1reaFTrtpcNIcw1lWZP/IFFGFze4NmIP+ld8s1X42ti10kTjow2EmkKHVNYrqpbk5rL3rZcQ7F5Xa7slTltlDV4JHZjNM0/Rq8VLBydTu9ys+EIU6fP9QT0nKMMcy8kU/415TlgqUlZT1yJhhzLrxZoqnlAFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163986; c=relaxed/simple;
	bh=tKpuYF4SZR5lkozkhfn8XfbK2UfIoUqnYkKbMoA133c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pCJhy5DxayTK9a0w6l8RmlPtXLJz6NVi6iA8jj87mncdqKpGTSVNOKfs04hRDFbm7WiqZwRAQNccgeHYA94NUX9r4TXJb5Xlef52tptbswx3IuP6xvgYFozSCDV6QlTefVb7QQU74lmj6arNPvgMNcjj1fgJ9fWQCed4pHOMHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zHPWFiF/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zHPWFiF/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7523BC40416;
	Tue, 10 Mar 2026 17:33:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8591060002;
	Tue, 10 Mar 2026 17:33:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FF741036891C;
	Tue, 10 Mar 2026 18:32:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773163981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GV/3yyZ/K5WPAlPx10KVrpjD34hKneXHwsacFm5yDNk=;
	b=zHPWFiF/U1qmeqt696VrBIHDjnldCPoHr6tmMQwbmcp53DwLjD6Zgpv9BTCRz2FPTTYA5h
	c/vjHW9wRtidn0qowanw4btRtvhiQzyYeiCQvH6QGZNK8pmv3ZUvFgsqaTmBezeAfeGynd
	tfclbhTFoadOd3XyXyrTvf3hgUZoL3eFJ7Q1PQqIy2cwqaFBCewQT/cuirN5oYvE/SEg3y
	k5/z5qC9QNn+KwtCHXVVI5GfIQGrCzpycusii2Mst4K840wue0GosU0jng5deGPmsF+OGx
	j5df5QrqotqBdPQtDiYb0dAds082NviHpmnkEGiau3xRwpikI8is+eXo+n7nwA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH 0/5] watchdog: rzn1: Add support for direct hardware reset
Date: Tue, 10 Mar 2026 18:32:41 +0100
Message-ID: <20260310173249.161354-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

The current watchdog driver handling wachdogs of the RZ/N1 SoCs is based
on interrupt only to perform the reset. On the watchdog timeout, an
interrupt is triggered and the software initiates the reset.

The watchdogs available in the RZ/N1 SoCs can directly perform an
hardware reset using their dedicated reset line.

On timeout, the watchdog also asserts its dedicated reset line. This
reset line is connected to the reset controller (part of sysctrl) and,
if this line is enabled as a possible reset source at the reset
controller level, it initiates a system reset.

This series adds support for this feature allowing watchdogs to directly
reset the system with any software needs when a watchdog timeout occurs.

The first two patches are minor fixes and improvements without changing
the current functional behavior.

Patches 3 to 5 add support for the feature adding:
  - The reset line description in the RZ/N1 watchdog binding,
  - A new helper at sysctrl level (sysctrl is handled by the clock
    driver in RZ/N1) to enable watchdog reset sources,
  - The support itself in the watchdog driver putting everything together.

Best regards,
Hervé

Herve Codina (Schneider Electric) (5):
  watchdog: rzn1: Fix reverse xmas tree declaration
  watchdog: rzn1: Use dev_err_probe()
  dt-bindings: watchdog: renesas,rzn1-wdt: Document the reset line
  clk: renesas: r9a06g032: Introduce a helper to set rsten register
  watchdog: rzn1: Add support for direct hardware reset

 .../bindings/watchdog/renesas,rzn1-wdt.yaml   | 22 +++++++
 drivers/clk/renesas/r9a06g032-clocks.c        | 32 ++++++++++
 drivers/watchdog/rzn1_wdt.c                   | 63 ++++++++++++++-----
 .../dt-bindings/watchdog/renesas,rzn1-wdt.h   | 16 +++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h | 12 ++++
 5 files changed, 131 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/watchdog/renesas,rzn1-wdt.h

-- 
2.53.0

