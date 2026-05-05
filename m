Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209A1A5B90;
	Tue,  5 May 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973208; cv=none; b=Ogi9csMooaFe+50YPVRGzBdIKUH69ANGVezVzH2YXbLirhMLVa9NAecWbVDL25IoFQsmhNxHFnIsGouCG91Dz9A1iuNwSzltENHYryBhUViXP+ZEJNo5jlevh9W242CstItkj8NbYUKvtQ4r4adVRpI9I5wOGDrkyN5fzSiV0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973208; c=relaxed/simple;
	bh=hGOf3RdeFW/xICBXzOqukBR6wqQ4Lh/uVDIalXsOgIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eGscF/xlSEwQUX/hIgaEjK+/ULDLh0cHfPzXo8oy0q9oPWOUe6R5oJY+ZgN3Dch7FOZYVmXI3zOeB0dL6u0b98F/dILJMFuPHiezhKQe0ICbv02+tefjXiPhACjzNonAPvdUPYoR8WYHFJ7IBfYBieTx8idq6B5ZweMDNiM6WWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=jNfpZ6Hc; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="jNfpZ6Hc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777973200; bh=hGOf3RdeFW/xICBXzOqukBR6wqQ4Lh/uVDIalXsOgIA=;
	h=From:To:Cc:Subject:Date:From;
	b=jNfpZ6HcZJVGjOPHhBK4glaurjxQMzxb+XwEnY44BfHlNsOn+N8RwhQVl7yk/XaEF
	 jHmHy+eFBpeyBTePXk6se1/SACZzAJe2KIBz1ztcLvFC48jBSLnkNOvx1XCQE/87/t
	 ampC0ATwjIT7LfmHNBFrKXEfzdKsW8B18qdQQEhs=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f9b7d0-88c8-7f0000032729-7f0000019242-1
	for <multiple-recipients>; Tue, 05 May 2026 11:26:40 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  5 May 2026 11:26:40 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Cleanup Linux Watchdog documentation
Date: Tue,  5 May 2026 11:26:11 +0200
Message-ID: <cover.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777973200-54616582-A274341B/0/0
X-purgate-type: clean
X-purgate-size: 1840
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

Hello,

while reading the documentation on the Linux kernel watchdog
subsystem[1] I noticed some strange looking formatting: `struct`s are
detected automatically by Sphinx and the word **after** it is considered
the name of the structure, but the watchdog documentation puts the name
**before** the word `struct`; this leads to the wrong word being
emphasized.

Also reorganize the index page to better separate the documentation on
generic infrastructure from specific drivers – which are mostly obsolete
and relevant for historic documentation only.

Please apply; thank you for all your work.

Philipp

[1]: https://docs.kernel.org/watchdog/convert_drivers_to_kernel_api.html
---
Philipp Hahn (5):
  watchdog: Change suffix .txt to .rst in references
  watchdog: Move `struct` before name
  watchdog: Replace intermixed tab/space indent
  watchdog: Separate kind of documentation
  watchdog: Prefix WDT with ICS for clarity

v2 -> v1
  - Rename wdt.rst to ics-wdt.rst
  - Expand abbreviation "ICS" in more places
  - Fix wrong reference to samples/watchdog/watchdog-simple.c
v1 -> v2
  - Drop invalid SPDX change to Documentation/watchdog/index.rst
  - Add SPDX to Documentation/watchdog/wdt.rst

 .../convert_drivers_to_kernel_api.rst         | 28 +++++++++----------
 .../watchdog/{wdt.rst => ics-wdt.rst}         |  8 ++++--
 Documentation/watchdog/index.rst              | 20 +++++++++----
 Documentation/watchdog/watchdog-api.rst       |  4 +--
 .../watchdog/watchdog-kernel-api.rst          |  2 +-
 drivers/watchdog/Kconfig                      | 10 ++++---
 drivers/watchdog/smsc37b787_wdt.c             |  2 +-
 7 files changed, 44 insertions(+), 30 deletions(-)
 rename Documentation/watchdog/{wdt.rst => ics-wdt.rst} (91%)

-- 
2.43.0

