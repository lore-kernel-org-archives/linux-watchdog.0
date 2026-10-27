Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116090;
	b=ch8xScQp2MkAZE+KuL+H4RuwsOgElOSIj01JzMHDzIKLJR8tdQHEyyuWcHPbNCvNj9dI
	 c9dvk+scAatgkN6QiYHutxjyzB4OKp+QWqjpVMsHhJ9gekfFSwXmTvr6F8NNmgBmC4psL
	 qZoptLFwzerACA75QIAVls47WC62T04OAD1AF5+0X8YJ2Bsylk+XkpN0sIuOuh3+FHTX/
	 fhxTIZ/rn/+yUvf5zvpXZmtty9woVYEasMl/S0WLHx5DvLnHQVdZmPy5pD20WthnsSyMf
	 yW2UOpY07AcCwq2j1EWdm5TDG8SxNxYkyMRuJHf0IWLXQMvZ+xPfn4JucF9N1kfE1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116090;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=l4PIwHarvU3x6l6mvAUeWbDvn4alE/qwD9vM0tpTFxU=;
	b=GHqQJwZE69Paqe+3PADZ95Uu51g6vHCRUbjr9OXGtbasdFhe6xaX07ILAvY0TVGRMJLh
	 4/YRABhtqeQriddB7gQpje9LcCAoPn7YjYuFveM5UfbxtUQUNd/E2Gp6mCUIX2gHvg+L2
	 iMuEQanCkc/Iki9AWPyKaFcgJZQ8zqyC4j2OXU+EXH+zqPAboCgGhz6eZYUMsDqHDCjM8
	 jylYCQwOWDg0L6aFdBCHVPs9qrGnc7Dpsg98WNVAvgfUNQOzod49QNz5+D+f5EwZAawSo
	 WCRCeyMe/NNB3vkPRfzkhLvD7QJ+L1MYqXltkRxtgR7Qw0/Mm/Rl8R7QyLRIfdkd/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=5fhR0k5E;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0386607351C
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0386607351C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=5fhR0k5E
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id LcyMxYYb0JFmFLjPExKNsz; Tue, 27 Oct 2026 15:48:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjPExRwktH2S8LjPExHjWa; Tue, 27 Oct 2026 15:48:08 +0000
X-Authority-Analysis: v=2.4 cv=Mfxsu4/f c=1 sm=1 tr=0 ts=6ae0c7b8
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=5xi0HWLX7wOsXyuw-usA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=l4PIwHarvU3x6l6mvAUeWbDvn4alE/qwD9vM0tpTFxU=; b=5fhR0k5Equzd
	tJkHCgJsHV9Bn4q11Yq1ibyyfpZWgHceqSljhDyQEbmfMPw4h4iKY/PLx29g96NHAy2+aqf0aGdw3
	ekYfv51rtSV/JG1O2/Jy4pfeWJcpLTHGrKDoJPwxTE9QuycbX+Gpv1HPz/i3WswMbmXaOdsS2ugnB
	khrJzcL5iMk8wZMb5RbwRE7UeIUWkZUfb6Y/9LRPtw0/Hf6RRA2TNld8i0gw4l3NdPOulIMZLvc9S
	w58BzP64nDq89zE036v0+qxoTuHOvwnSwDkGx74n/i5En3B3h2qeQQNTy5YyDj6YAGNPsfwz8eY/7
	V18JGW0lWjh3GyjLKXOu5g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37930 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjPD-00000000TgO-3kcO;
	Tue, 27 Oct 2026 21:18:07 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/8] watchdog: core: Clear wd_data pointer on errors
Date: Tue, 27 Oct 2026 08:47:58 -0700
Message-ID: <20261027154805.2518806-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027154805.2518806-1-linux@roeck-us.net>
References: <20261027154805.2518806-1-linux@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLjPD-00000000TgO-3kcO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37930
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 44
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEGb16MuyedNH/vH5eu18P8SQE1mOP82Ax/2cxtCuR24HYmwydD+1KbWxD4bqzmsY0c0IWhxOUsuEXr+F9TYlrHTCCok70EO8Tm2ZniKXu5h/zN/AWXx
 4WQZT/f7syYNJyXqWQhTtQj0tHW9khy5pxXc+aT2wwPKI6tGKKHzuTqUHX73nKLYJtDZQ+50YcgRG02FifST6jG4f4xkcxfwVAZt5q8nQupiVuMDyV/S9jAh

In watchdog_cdev_register(), if device registration fails after the core
watchdog_core_data structure is allocated and assigned to the persistent
watchdog_device structure, the function frees the data but leaves a
dangling pointer.

During device registration, watchdog_cdev_register() links the newly
allocated wd_data to wdd->wd_data. If a subsequent initialization step
fails, such as the watchdog_kworker validation, dev_set_name(),
misc_register(), or cdev_device_add(), the function cleans up by freeing
wd_data via kfree() or put_device(). However, it fails to clear the
wdd->wd_data pointer before returning. Furthermore, if cdev_device_add()
fails after misc_register() exposed /dev/watchdog to userspace, a
concurrent open may hold a reference to wd_data while the caller frees wdd,
leaving wd_data->wdd dangling.

Fix the problem by clearing wdd->wd_data on all error paths during
watchdog registration, and clearing wd_data->wdd under wd_data->lock if
cdev_device_add() fails.

Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
Assisted-by: LLM
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Reviewed-by: tag

 drivers/watchdog/watchdog_dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..ed5b35184271 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1033,6 +1033,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	wdd->wd_data = wd_data;
 
 	if (IS_ERR_OR_NULL(watchdog_kworker)) {
+		wdd->wd_data = NULL;
 		kfree(wd_data);
 		return -ENODEV;
 	}
@@ -1046,6 +1047,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	dev_set_drvdata(&wd_data->dev, wdd);
 	err = dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
 	if (err) {
+		wdd->wd_data = NULL;
 		put_device(&wd_data->dev);
 		return err;
 	}
@@ -1066,6 +1068,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
 					wdd->info->identity);
 			old_wd_data = NULL;
+			wdd->wd_data = NULL;
 			put_device(&wd_data->dev);
 			return err;
 		}
@@ -1084,6 +1087,10 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 			misc_deregister(&watchdog_miscdev);
 			old_wd_data = NULL;
 		}
+		mutex_lock(&wd_data->lock);
+		wd_data->wdd = NULL;
+		wdd->wd_data = NULL;
+		mutex_unlock(&wd_data->lock);
 		put_device(&wd_data->dev);
 		return err;
 	}
-- 
2.45.2

