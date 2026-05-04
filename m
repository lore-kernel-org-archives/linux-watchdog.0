Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAA3A7F4D;
	Mon,  4 May 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902755; cv=none; b=d39Rh09wYSPsNbuovJUvbGuPLOpn/y8GQQsKbA4dGp4dOrKphQNgKLO/2v5lhnXOViwD+RE3oTIRFkWjaCyzJFML+RvB+Sgv2Io04DdEKKfgEvtKm8CvW5vkj1zZUzQubgMXsFzsQU9tsG07nAMyooyBaBDkGhUA+QV97YKtZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902755; c=relaxed/simple;
	bh=jMj3wMk9KiHUQnn60IoB3KkmCvFOVdxij1Ncga2+HQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvrfPEDYNlgetwzT7eTl1eZidyJ54kHmlszaos5X/ZjQB4WgQTGRahPpRt044bAuLOohQZmPp5WUtyteutuABBgaSzXdfMwIx658I9lY8TyofQdV1ygmqOpQHnPbqZt2M+TmFddjOm8E7GlQKFvsPqBDxi3PJRya1bnZjPw5wsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Ekf++KLn; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Ekf++KLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1777902749; bh=jMj3wMk9KiHUQnn60IoB3KkmCvFOVdxij1Ncga2+HQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ekf++KLnDxwH6VOdZZSqGicfPp+Cjxg6vBQPaEN3+DYwzcTt3DQzeB8YIQ39/MoJC
	 mRXjd09elzLIlSq0wfLf8f/1aNfjdA+J72tYLZIq3DkKntFlAA3m4VKLWA9TvNeI3j
	 eVYvtmc7c4V4HMF2I6j8p/zkN7qsUpWTyOdjmXyI=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.56.1)
	(envelope-from <p.hahn@avm.de>)
	id 69f8a49d-88c8-7f0000032729-7f000001e39a-1
	for <multiple-recipients>; Mon, 04 May 2026 15:52:29 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  4 May 2026 15:52:29 +0200 (CEST)
From: Philipp Hahn <p.hahn@avm.de>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] watchdog: Replace intermixed tab/space indent
Date: Mon,  4 May 2026 15:50:01 +0200
Message-ID: <e1ccbfb0efb9a9f508d1afe10263af1578a1aa46.1777902230.git.phahn-oss@avm.de>
In-Reply-To: <cover.1777902230.git.phahn-oss@avm.de>
References: <cover.1777902230.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1777902749-A1E51582-8021F208/0/0
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

