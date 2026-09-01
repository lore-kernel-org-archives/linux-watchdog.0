Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96D39021C
	for <linux-watchdog@vger.kernel.org>; Tue,  1 Sep 2026 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298990; cv=none; b=HWGO+H+R+N4a5Hvp1MUhuFA8JI3gCj4KneY34zWttcTqbFWkWsQ1fbrJwDrRKVTfO1lQtEXF7MmiCOpYwdcc8c19nG1CPUldp4j8TJGYX6AxvnaIkyaaykikmFl0RjZiGjqaqKk4BWXdB14g8Ikwj8lO1c59SomEtme2Bk950G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298990; c=relaxed/simple;
	bh=WsfyOjAy0FkWiqJQx1DtNsaOL/vd8OJK2zTRhAM6XP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCunleKsXo8debjq6AVL4ucDgOjw+NBSpUO7OQJYg80xMt8IHKLSWHTCRIDiE0R51xYe6DeF95ZQ7TWg9DjUHauQdb1wfma9Y7v56lIvUMcPD7lDbehUgbcTKXelaNnIfxcEvwPVe/ktqt4MWioX8MpXdzJxYWGYRxOxzbSJeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX1NfIbU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxRoT3AR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX1NfIbU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxRoT3AR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788298988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJnGHCa5zu77CfKI5DRPOBnEPo8n3SuSuIiqIBE+PyU=;
	b=PX1NfIbUhQPT8Dx6egZsRJOgl78h87Gjzkr1cJLdQbqYG02Fq2r+CPjZY4NFNnhmc6A+t8
	zHnVmSCEwsUq6qP2dSQ4Y718CudzBB1kmgXC/iaZVyh2R4yWjFSG2a6IuBQlmXJU7UC8HT
	/Eq9NJ2DZvrzyQcP7nH8JVbzG1/1o0Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-jwwTPolAOb6gVFYmCbMU_Q-1; Tue, 01 Sept 2026 17:43:07 -0400
X-MC-Unique: jwwTPolAOb6gVFYmCbMU_Q-1
X-Mimecast-MFC-AGG-ID: jwwTPolAOb6gVFYmCbMU_Q_1788298987
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530006c6d43so6082431cf.2
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Sep 2026 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788298987; x=1788903787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJnGHCa5zu77CfKI5DRPOBnEPo8n3SuSuIiqIBE+PyU=;
        b=SxRoT3ARmo2IhNR0hbPf6aj7kJ6vQ1iA3sLRTNcceUs9o4hojfCy4LO4qLaCe0EVgz
         V39ZV2cbFgDgV1MZ7BiBwUJZXUPliNJ9gmxLbkI5bQpSBLZjrzBzhdrDtJqDuIgsGqE8
         iIPM6RD9OAFRVt9O0LoaKImxzE3ZDNojOughvkibGQxbszOfH6ODatK5tHzZutQ1xA7e
         3jRHy5PixmXHYsDRY73d8DWQdwuwxtQevXD8xZqkDHi2QqaS5/37xheb/zMQt1NCfuoq
         gMNt7t8rQhUsThpeW9cwlrBtQVLynT7cUsrimZtta8o7WQ/XQt87lAaTiUCSJ+y/rNxi
         AOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298987; x=1788903787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJnGHCa5zu77CfKI5DRPOBnEPo8n3SuSuIiqIBE+PyU=;
        b=Ex7zFN/qciRrvbxQw9C48OZdjFmRmqGGpg1O/az3gAtL2TVyhkbxwpkCHoO04l99hq
         nCOIv2CXMQRGABNihGptmX/kyTJIsShNB8XBkHsQruoVydzPOLaKNplg0QJ5jt8hi6nB
         o9VIOW2wGkW6yqWWpUfXAXkoWLJqZJVPVbixhzx1KiJB9hfW9e1Hx0p+zfZ8qPR9X/+w
         8IHtkhFdKusKcR+UGlB1SQwmDePusOaWJ+g06G6s7U1sLVwPUUH/9L/Zp4sLDJ6gT5l8
         UTojTCe9CUwAwHmyiJW7YEVpfl3wxWSpciOvgiwRQkariZtpvR4Mhc1Dc9mjNaFsJPrq
         /QRQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Bn7gq4onzYil7cqKvXi11Hhh64+oQEdAE26muMWnQ+UBbBdx6bhT33JoMtmOBnBePFNgNZATwUxcmRr4hw==@vger.kernel.org
X-Gm-Message-State: AFuF++kvFEFIQ3uofx24sYaa05HcJ3Ijy0WfDjorygripnwBK8ebM65w
	kHXc4NP2upyneRUqQ7V7ved4gJ694Q3a226KzNSjwlaU8MpJW+ktK+5XHUQXzn3F2GT3u7oM94V
	+p6cS97rDXA9XfoI8xBWZcX4EOzVUl/4ffCZ/AZKy9uvu887dvENzGxkpjs1g9GIcJKIw
X-Gm-Gg: AR+sD12flWoLRkYmNNday9nCAhb0Wp36IG21VeO5KXgcohjtIG04fX567SCBzK6mCIZ
	ww7jf8yncpcMfteSzj4VtZsTAwv9Tlv1TSWPSjmAq5c23LMN28taBmSv80xp/3pAhbrQ997yQfp
	2/GbzGDsjwjgid2h4lFny2haMUqAU4otGqvmeOK0b00MixUbbtKTkAlbjABc4+g1qzFxlIwVpHk
	NYe/WVqPMFckleuybTK+wVN/Y4JlgTrQxP7V0NtqQESs5u5T7hNAw+ltfZVH7zc6nizzn+8TbNb
	xvpl30s4Lig4K4o9KFQMkyHUmQbiywMC7KSwtdCry82xr1iXQi4HQXAiUTXBf7KrKMM/3KNVCkV
	2cgWpDY0FWjfGJRiiFCL5hIgmxqAhSHAlIGX2COzGsdplPBjgiuzdcrO6Ba9mK3szBFwR0FB45o
	Al4nPOBJf3um1wdZK9B3szgQ==
X-Received: by 2002:ac8:598f:0:b0:51c:805:1be3 with SMTP id d75a77b69052e-52fb96ffa65mr422016961cf.31.1788298986735;
        Tue, 01 Sep 2026 14:43:06 -0700 (PDT)
X-Received: by 2002:ac8:598f:0:b0:51c:805:1be3 with SMTP id d75a77b69052e-52fb96ffa65mr422016541cf.31.1788298986314;
        Tue, 01 Sep 2026 14:43:06 -0700 (PDT)
Received: from chaithco-thinkpadp16vgen1.redhat.corp (184-96-189-144.hlrn.qwest.net. [184.96.189.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53032ff5866sm5889811cf.3.2026.09.01.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:43:05 -0700 (PDT)
From: Charles Haithcock <chaithco@redhat.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Cc: Charles Haithcock <chaithco@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: Differentiate scenarios when watchdog is closed
Date: Tue,  1 Sep 2026 15:42:49 -0600
Message-ID: <20260901214251.760184-1-chaithco@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Presently, when a watchdog device is closed, we print "watchdog did not
stop" in a few different scenarios;

1. When nowayout is set
2. When the watchdog is able to close, has received the magic character
   to stop, but fails to close in device-specific code paths
3. When userspace deliberately closes it without stopping it

For 1, we explicitly print we can not close because of nowayout. Nothing
differentiates the other two however.

This change adds a print to indicate the watchdog was closed while still
running.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Charles Haithcock <chaithco@redhat.com>
---

v1. Introduce change and modify logic to differentiate
v2. Simplify but still differentiate

 drivers/watchdog/watchdog_dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d7895009a2..937bdd4c92 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -305,6 +305,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	if (wdd->ops->stop) {
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
+		if (err < 0) {
+			pr_err("watchdog%d: Failed to stop watchdog: %pe\n", wdd->id,
+				ERR_PTR(err));
+		}
 		trace_watchdog_stop(wdd, err);
 	} else {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
-- 
2.55.0

