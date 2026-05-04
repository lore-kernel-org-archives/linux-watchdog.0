Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8D3A75BA;
	Mon,  4 May 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893006; cv=none; b=YdoDgRx8DzytZHkXmLBkSxPQ/dxWTfRcYizWRmTOFSZpvbSqCdEMc7iK8kEZFNoxbx5kQSYq2qnclyt/084GxHeXSrxEC/WJPKrEok0truKZ/wZkR0n6m/u0jvJqbBs0VhYGGfzv9tGI9wFmzWeMWV5uqK1kr66hqWViSKq03J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893006; c=relaxed/simple;
	bh=nzMN3oHZQOtg4e8eYNrvOOnVGfe067YAON3LiB/SVwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDNQg+vrU4p8/m7wc/YlCtm46E5BjtDkuLqhCueS3XRWlmQX/kKTEyz/LMXR2zB/ush9uf/P3i+3d4r0VJJ7JwLpX9cNy302VzLjDCENANW3hpF1E/nJxNLi7qgJ/1yzGdQQi3jXaP5TzReHPeUHpFkefp6IZprpUa9do+ogwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=RxjEyxKm; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="RxjEyxKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777892586; bh=nzMN3oHZQOtg4e8eYNrvOOnVGfe067YAON3LiB/SVwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxjEyxKmUgnXwvdymTEnCl1FtzPmhxcOXc3zSVmzDRo6Dp3gKNuR4/uzppPbWy9Uq
	 iTrJ6QQzoIilm/O9F5MWYW1jZHkH/ztVmc9Z6tgFT5RgyIEZPikC1jeSeJcSxKIRUO
	 q2fsr2o5EEVRB3G6xuyHDLnTESB6EU5JKMUcbLdU=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f87cea-839b-7f0000032729-7f000001e270-1
	for <multiple-recipients>; Mon, 04 May 2026 13:03:06 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 13:03:06 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
Date: Mon,  4 May 2026 13:02:36 +0200
Message-ID: <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777892508.git.phahn-oss@avm.de>
References: <cover.1777892508.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777892586-4E6A2EA9-D08D2B1A/0/0
X-purgate-type: clean
X-purgate-size: 703
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

The identifier `GPL-2.0` has been deprecated in favor of `GPL-2.0-only`.
Change it to silence `checkpatch`.

[1]: https://spdx.org/licenses/#deprecated

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index 1cea24681e6bd..13e3d78254dd6 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0-only
 
 ================
 Watchdog Support
-- 
2.43.0

