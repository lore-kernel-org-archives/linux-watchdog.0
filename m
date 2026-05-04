Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2773C2E;
	Mon,  4 May 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892934; cv=none; b=imkNydIakK4k+X0xbCDWKuCoTfcLOYzjmjAicqknkd5qskDBt+roNQxqJzXmx1fjre/H9lfLi+V98/CSMeTj/1yQp1Jgs9G8y6vMR3MiyO0PO9QImabmPTG+gUkk5FPoahPbvywpylfGfejE/H95K1IFsBmI+oMpZMAIT6EvLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892934; c=relaxed/simple;
	bh=mdG9spAtI5o5r5xXfv5TTUnmkfy1AKgGU4u+Puqhd5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZ5WwZw/oWWRCSGaOTamTYDWI13iq3He6BLb0gkGBNGgt7nPO70na14c6SnV1Aoq1WaV+b+y32FIjHJwetWoNe0Pa/2jff2gx3fVyAUTf6jG9u9o1M7V2kCKpCQD5BHGeSxD3RjKigr4O0fJKiTcFb9VNUkDs2fjJbUvDCtPvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f87ce9-88c8-7f0000032729-7f0000018666-1
	for <multiple-recipients>; Mon, 04 May 2026 13:03:05 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 13:03:05 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Cleanup Linux Watchdog documentation
Date: Mon,  4 May 2026 13:02:35 +0200
Message-ID: <cover.1777892508.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777892585-4BE05582-3CB47AEC/0/0
X-purgate-type: clean
X-purgate-size: 1482
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

Philipp Hahn (6):
  watchdog: Fix wrong SPDX license identifier
  watchdog: Change suffix .txt to .rst in references
  watchdog: Move `struct` before name
  watchdog: Replace intermixed tab/space indent
  watchdog: Separate kind of documentation
  watchdog: Prefix WDT with ICS for clarity

 .../convert_drivers_to_kernel_api.rst         | 28 +++++++++----------
 Documentation/watchdog/index.rst              | 22 +++++++++++----
 Documentation/watchdog/watchdog-api.rst       |  4 +--
 .../watchdog/watchdog-kernel-api.rst          |  2 +-
 Documentation/watchdog/wdt.rst                |  6 ++--
 drivers/watchdog/Kconfig                      |  6 ++--
 6 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.43.0

