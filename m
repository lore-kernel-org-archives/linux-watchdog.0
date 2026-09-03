Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE9376BC1
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459650; cv=none; b=VNHBpvi8vGAF28M+eYEX3zrCfJF1URs+xMRKKHu9jwR+CgNoc/eEo4Pkiirn3Dw2mMsCM8uvEqhZzBhnP1DhB5jxxE1tGJbUgpMlsRX4xShpwTlQyMymzmooGMPV5o3X48q2MmkVuwtMwId4diDCF9tC9nRw6qsheLmC3UCjET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459650; c=relaxed/simple;
	bh=JRbLexkc5ZNSe0vuuunKAGUBqAfbCc+sL6aPYqB5AJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ra5hTkBGdrIlsOctwqaA4sTHbF3K356wE9F2S4CIyg29Rip7+y+jyANKuOhG61+nNxIcLD+S/Iwxvcu2IQnrOTLEekzHK5QUvMtSIaEnqV2DB8CKy9uu/51zXHCoGmhUnTzEbpsxd2kiC4YSoA4HJ8EoLlgkBs77kOTYMS9xC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoI6idbq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoI6idbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788459647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rz/LqFTWwylS4cAHF9vBCU7twVpk6BXJeuhuFh7psfU=;
	b=LoI6idbqlA0euP+rGBtuUdz7OUS8EjUBOdqsJKXs7Su6SoiWFheKt/gztBmIFq7sECCHsS
	Atxru6Wg9OfIzPL/lE9cgYUjL9s5gK7NjYmHLrTuucv8Da0Ta/koH9hY17EZiCoj1gOiVD
	sqHlTSR4oNJmG9xcxFsvL+4m4Qio60I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-1g2SbZP5OW6j7gJt9Bp0nA-1; Thu,
 03 Sep 2026 14:20:44 -0400
X-MC-Unique: 1g2SbZP5OW6j7gJt9Bp0nA-1
X-Mimecast-MFC-AGG-ID: 1g2SbZP5OW6j7gJt9Bp0nA_1788459643
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FB6E1954AD3;
	Thu,  3 Sep 2026 18:20:42 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54D5830001A2;
	Thu,  3 Sep 2026 18:20:40 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Curtis Klein <curtis.klein@hpe.com>,
	linux-watchdog@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH] watchdog: fix hrtimer start when pretimeout is zero
Date: Thu,  3 Sep 2026 14:20:29 -0400
Message-ID: <20260903182029.936030-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Per the watchdog API, a pretimeout value of 0 disables the feature.
However, watchdog_hrtimer_pretimeout_start() fails to verify if the
pretimeout is non-zero before arming the timer.

This omission inadvertently starts the software pretimeout timer,
which could result in the pretimeout handler executing incorrectly
when the watchdog timeout is reached.

Fix this by adding a check for wdd->pretimeout before calling
hrtimer_start(), ensuring the disabled state is respected.

Fixes: 7b7d2fdc8c3e ("watchdog: Add hrtimer-based pretimeout feature")
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/watchdog/watchdog_hrtimer_pretimeout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
index fbc7eecd8b20..49a05ea60c97 100644
--- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
+++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
@@ -30,6 +30,7 @@ void watchdog_hrtimer_pretimeout_init(struct watchdog_device *wdd)
 void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
 {
 	if (!(wdd->info->options & WDIOF_PRETIMEOUT) &&
+	    wdd->pretimeout &&
 	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout))
 		hrtimer_start(&wdd->wd_data->pretimeout_timer,
 			      ktime_set(wdd->timeout - wdd->pretimeout, 0),
-- 
2.54.0

