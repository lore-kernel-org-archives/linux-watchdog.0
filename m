Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93513A7844;
	Mon,  4 May 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893006; cv=none; b=o/mgxUlb8l25tmYP3278O99qWn5lKxxLL1p4OlJ0/42No/3B63S11EUmUtGpEUWn+6erhTCaVQ/jRrubmGpK0FMPLufwWXZ9jIOPMSeJsbTJPC9qAuLyNNIgKJSKzw8lsez198kvoudtj8EZjmCZN1kn0UQLYQ/FK72EA5YqnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893006; c=relaxed/simple;
	bh=jMj3wMk9KiHUQnn60IoB3KkmCvFOVdxij1Ncga2+HQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjU766AUgNFa54QP+6VyZB3C+iwvQYzNuS8tUlLugvY7xPRhsa1rcIn3lppLoCOsklf1n3Jy/ON8nWslDkGhmQQcVvzVSUQgsfZhud6ct3AuXbuhOfkLHvcU/JaO4AMV1vKfd8PgRUbAG53PW3ec7Gsi8GE8AMj5SbSjXN796Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=nC/kQHWh; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="nC/kQHWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777892587; bh=jMj3wMk9KiHUQnn60IoB3KkmCvFOVdxij1Ncga2+HQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nC/kQHWhJPwjBXZ6vGGklaCphCHIh/3MNDm0/U+rOvRaLB3BlNP7evKvKXaykZx4Z
	 dLg4ikvBTNQNlq/B5Nf8HeGpUWHOscKBOjW00fb/nAsQzY1JK+ZWxsgs2v2uFr5ijd
	 Kd1GqWssWwfNjiwVB0oYhTBU+1uf/ps4xz4k8rfI=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f87ceb-839b-7f0000032729-7f000001e276-1
	for <multiple-recipients>; Mon, 04 May 2026 13:03:07 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 13:03:07 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] watchdog: Replace intermixed tab/space indent
Date: Mon,  4 May 2026 13:02:39 +0200
Message-ID: <9b11721eb1855418302af37691f932fac30b6a0c.1777892508.git.phahn-oss@avm.de>
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
X-purgate-ID: 149429::1777892587-5CE8FEA9-5D2A8F5B/0/0
X-purgate-type: clean
X-purgate-size: 1017
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

From: Philipp Hahn <phahn-oss@avm.de>

Consistently indent all lines with tabs instead of having one line using
blanks.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 Documentation/watchdog/watchdog-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-api.rst b/Documentation/watchdog/watchdog-api.rst
index 2c138eaa43397..78d0940155b13 100644
--- a/Documentation/watchdog/watchdog-api.rst
+++ b/Documentation/watchdog/watchdog-api.rst
@@ -161,7 +161,7 @@ available to ask what the device can do::
 the fields returned in the struct watchdog_info are:
 
 	================	=============================================
-        identity		a string identifying the watchdog driver
+	identity		a string identifying the watchdog driver
 	firmware_version	the firmware version of the card if available
 	options			a flags describing what the device supports
 	================	=============================================
-- 
2.43.0

