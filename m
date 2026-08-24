Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5D36194A
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604945; cv=none; b=n0+xXiD60nYj/YbtQLOckUALloN98BFa+3nBITOITHwJOLbn9DU/gw6P8nXVstF3/NYU4aTN6kfR7PUvPVcTjwZAlp4E7PkDRD/zRzuoCYKBXL/swzqjJjSPo197BLqHsvqY3BhTe9+BziifMMYWfDTvkDf5PxF2VARuPrFEfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604945; c=relaxed/simple;
	bh=EtnSZDpzebFks+Xv5PhTHAHe1xB7IB/xJ4tYVK/jqP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtYFM96TEKHDiYyTKcQQK2WQ5Y9WWDBtPJmplr+CAh0fd0heBS/ZIKkg/0sOEuastS6Uj6KGvtsRmCUnUzESxmYHaH2lzUOEUnYVIOYWBG4IiTxrs/XubEcK/tTtmTVfP5PXr4eRqMhhRx8CuKLSXr2acSP62ei7bazWrfVBhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFuXa2Tc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hV66yVdA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFuXa2Tc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV66yVdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787604942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YZA7rXybjQ/9nL0WGdpemcuGoEnQB/ztBkm8ZTqMROI=;
	b=eFuXa2TcrqRfNxHphoH/1mfnyqW6PrE7DYKiKkCoPFavQkau1Ka3uaQWSFckRvGtIqTXGx
	iqtPzkTfDvJusYjGO2eN7cX8DOywkVxbpx94U10Am8FA3rqYjpDO/ftnlj51eqXZCL7FrQ
	zOg1m9HNym+/AYX0skRT1UAAt18ZUqk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-czzIX3qjP1OrWN3uN4wp_Q-1; Mon, 24 Aug 2026 16:55:41 -0400
X-MC-Unique: czzIX3qjP1OrWN3uN4wp_Q-1
X-Mimecast-MFC-AGG-ID: czzIX3qjP1OrWN3uN4wp_Q_1787604940
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52769fc3f2eso56918751cf.0
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787604940; x=1788209740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZA7rXybjQ/9nL0WGdpemcuGoEnQB/ztBkm8ZTqMROI=;
        b=hV66yVdAxFWIWeFNWCxbjQUcVF+5pgVaxwHNp3Da4iWg/6dM2nm9z76EI1y53xchFV
         9RvwdJAOgeMZE7F8TYHDtcdW2HA53nW4yuOgG0PVGytFsPYKYFNwLD/dTbFPFdWekFxJ
         hhIKgEcdLMt51GAcEUGE4P7F3tK7M6/DkVmNmZuB/Css+9SAQhK2QA3Oh+3Xcq+yJKiu
         DoqgMns7O87gaw3V/B9qAqH68tGM+UUUOgLZPZMUTIPHtXYaJsAIeyRf3/BZzg2DlcsS
         x8O44O3f9SuBrr/hl+k/5Reh4n8giUitM8kwlX6Ier1RsipGjgNwkigXfmbUjzh8DKmh
         /uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787604940; x=1788209740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZA7rXybjQ/9nL0WGdpemcuGoEnQB/ztBkm8ZTqMROI=;
        b=fuEGJJ4kvXR7FtBgQAQ833kX/HV8xYDzW4WP+qx+Fm5/3gww/Oe9BuI1CyVbxuXwBr
         wgEFko4LbHtB8y/NhQkqbAmDf7sRBJLRSFeMpVWD1eSqqbBR6B1xJETi2KUAGcktkYC7
         VxLWbrw5S2IekpYuYMS7Jil4rgc8VQZxW9KxCBSYX2YTb1isUS/Qt6ca1Rk2R7t9TJ4u
         MWn19eYhbnGywLi6d2w3/nHImFz31mtESAfiUGo8NLQ9GMThOVI/DixSVpP71ATxpTz+
         KgkGkY8O+pDq8MYVs+lpuUtxVSObLI2GCmMJtt5il8bHUyClOrbQj7DnB5puYaEvwt9y
         Y2BQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKYTC2HBceCRsjFjd/Zu8/oquW9uqhtPjwKvCs534CI6TCyd36tzyc9cO6owP+enqBupgW8KoFMjHl9BY+sQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k/9+TfcfjjxvspZwcxzQzqx25h4SXJoeZyHTbloighFPgfl28m
	1blTpCwd+0BkYxdP8n/cvg0KheLNkn2nFKna4KZsWULbGddiHiCivZVxvA5EaMEppnGO7/DcIcy
	RBgXPxjLTxHVmSZ+pqxNgtZPjn2dO/zNpxnof0vp0W8f537l3G5khFf6Okus4sMEklikH0LhHjS
	C/
X-Gm-Gg: AR+sD122TQtDw6JnDKWgBexCr31VhK+b0z0dUezBJLaA62iwMnp/7tlmo5UTkhSAuVj
	cOBVQ75alu3n5JiJCUyxo18UCMQ+QAFyy18VU70XM7qzlgmBCpPGjeF7y+dQkLnzkwMRRG1US6Q
	hPj81OsNYvKr10rN++9DwzXyhjfaj19R7HbO6h9lRFPNRIiawfoGcuNYDh/ZdAoBuitLFDlnm29
	7JbUkSWztZnKC5jAF/C1ogtaK6WA7t2n6SXg1nVAQrDfswSsqIStqaXmd8+F8KR2CRbBM1PBcs7
	FJSgzu1YXwoZ+85YJrPFqyc17V9qlffGs1mEGRf9OZt2axDiG7/KrNlHGKeI4+wgDsw/X2svqeY
	PyBGy6xWIX7GQGAyvs0Y+sTJJFh1KaStBF2mbyDNr/8uBz6Y657pLbESLI2muljIZS/TyIw==
X-Received: by 2002:a05:622a:cc:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52df5a9bf53mr285970511cf.39.1787604940276;
        Mon, 24 Aug 2026 13:55:40 -0700 (PDT)
X-Received: by 2002:a05:622a:cc:b0:517:87bc:9b47 with SMTP id d75a77b69052e-52df5a9bf53mr285970121cf.39.1787604939825;
        Mon, 24 Aug 2026 13:55:39 -0700 (PDT)
Received: from chaithco-thinkpadp16vgen1.redhat.corp ([2607:fb91:7c7:872a:57eb:e0b5:a75e:bae8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e0996b4a2sm56239751cf.3.2026.08.24.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:55:39 -0700 (PDT)
From: Charles Haithcock <chaithco@redhat.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Cc: Charles Haithcock <chaithco@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Differentiate scenarios when watchdog is closed
Date: Mon, 24 Aug 2026 14:50:47 -0600
Message-ID: <20260824205051.4117285-2-chaithco@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Presenty, when a watchdog device is closed, we print "watchdog did not
stop" in a few different scenarios;

1. When nowayout is set
2. When the watchdog is able to close, has received the magic character
   to stop, but fails to close in device-specific code paths
3. When userspace delierately closes it without stopping it

For 1, we explicitly print we can not close because of nowayout. Nothing
differentiates the other two however.

This change adds a print to indicate the watchdog was closed while still
running.

Signed-off-by: Charles Haithcock <chaithco@redhat.com>
---

 drivers/watchdog/watchdog_dev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d7895009a2..a571dea353 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -955,14 +955,17 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	if (!watchdog_active(wdd))
 		err = 0;
 	else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status) ||
-		 !(wdd->info->options & WDIOF_MAGICCLOSE))
+		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
 		err = watchdog_stop(wdd);
 
-	/* If the watchdog was not stopped, send a keepalive ping */
-	if (err < 0) {
-		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
-		watchdog_ping(wdd);
+		/* If the watchdog was not stopped, send a keepalive ping */
+		if (err < 0) {
+			pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
+			watchdog_ping(wdd);
+		}
 	}
+	else
+		pr_info("watchdog%d: closing while running!\n", wdd->id);
 
 	watchdog_update_worker(wdd);
 
-- 
2.55.0

