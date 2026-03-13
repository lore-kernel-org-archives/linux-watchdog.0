Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E33822AD
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393872; cv=none; b=gLjCJwHapd04PT+LOjtYbs3zAhv3TpGFlY9r6rq50fW/zqPzhM04Po2pyntJP1whXxa+VYAF8oxnVf0AnKFdlCItPbE3/oxz/7tG0SUDAyA30WkXQ+YCI7Ubni6TI+xT4NHNJvWrjl/rA9rrpXqob3Cyu7qLWSe8e6LXqvZi0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393872; c=relaxed/simple;
	bh=dAmU8idGkuMvsrFcSryOD0FTNdsKN5HQRLdF+8gRxSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mpJiCBxiyR0b++3pVWE8pnGOy3d+KZ20A2yjNxfz3noJeXnmjm+bZdHa3jVXt1S0K7W59npKBIaCRgYu3J2CNQ6eF9DQpZxN5ELCy0oukzgrvXise6L3XWvbBxTkaYYfPh2S8Ot82ERapLKSVaLFjNiM6yUojT5l6i868lLOOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G6PtBbzy; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G6PtBbzy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 94960C40435
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 09:24:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71C3160027;
	Fri, 13 Mar 2026 09:24:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58DF110369DD1;
	Fri, 13 Mar 2026 10:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773393867; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9BC2/Ee2NSV1ueoD+FcjW/TcAiBJTqR0eFXTRftNYiA=;
	b=G6PtBbzy77KSqE86KtNrheF8cMCrcWOU2IpnFCATBFYMLBdNnaNr8KxIw04pMpVGQH/dPW
	eSFNEwFQaxnFSINhQhffhYeAUEGXWXA4nOT1G2f1jvLHBefvfYiiHjTB8ac6NHxsjBc72O
	mCvL/rOxmI8U1t5j5FhhftLFe9FrRRFVuPkYVVIz6kT+oEDwPDNksk4ZYt4SY2Xxo37xTT
	f9otIqLSVl9pgWxuTBRPlmGOkjzun64g2ltF+nbj2OqNt1o26gVToLgkB3120ETCXLTng6
	T9RTQdCvnWC52xRP4MGc9v4QwliCJGbZPhuwLb0iH3cfpyyGfr8qfhmmXEIwSA==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Subject: [PATCH v2 0/3] watchdog: rzn1: Add support for direct hardware reset
Date: Fri, 13 Mar 2026 10:24:13 +0100
Message-ID: <20260313092417.294356-1-herve.codina@bootlin.com>
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

The third patch unconditionally enable watchdog reset sources at the
sysctrl level (sysctrl is handled by the RZ/N1 clock driver).

Compare to previous iteration, this v2 series reworked the support for
this feature moving from a DT property and a helper to enable the
watchdog reset sources to a simple unconditionally enable of watchdog
reset sources.

Best regards,
Hervé

Changes v1 -> v2:
  v1: https://lore.kernel.org/lkml/20260310173249.161354-1-herve.codina@bootlin.com/

  Patch 1 and 2:
    No changes

  Patch 3 (new in v2):
    Unconditionally enable watchdog reset sources

  Patch 3, 4 and 5 in v1:
    Removed

Herve Codina (Schneider Electric) (3):
  watchdog: rzn1: Fix reverse xmas tree declaration
  watchdog: rzn1: Use dev_err_probe()
  clk: renesas: r9a06g032: Enable watchdog reset sources

 drivers/clk/renesas/r9a06g032-clocks.c |  5 +++--
 drivers/watchdog/rzn1_wdt.c            | 22 ++++++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.53.0

