Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A443D4F4;
	Tue,  4 Aug 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835329; cv=none; b=odiAQcszJafP0vVqcDrzUH0wqNpL/22TJeKc/8u9IBhoez9C53BxCPKR/cCcg9Fh8voDfgdVIx2HVobA4PIBnOQX1xrI7fbYT2n18ybziAvh+BqBxISx0Qq2qkT12u9iBDpFyOvu8F23g0+rbuOR5lzjRGG8vNwc4FB/Xc623Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835329; c=relaxed/simple;
	bh=Jww2Z7fvh+tZFB7Df28/xpCuhfGnEybrqIGfbSewvRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emANXQqLvkLd47TPJKPG87v4VUNZXVNkgEZVFHbh5yVJNA9OKb5lcnEDWdo8T0xzAPvICI9WYnNRaqSZxjpkEov7BOQ0X5i98DrKT2xhLB/9d4eHgKkBZOkge+hl/dW/FD5DGxhRCpSZRE72nZH7ftTaYH5+/cVw7/bjlOcNdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLX8wO5G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLX8wO5G"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CWC43531682;
	Tue, 4 Aug 2026 09:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kdo9Gdgjwm2h+DY+NxyO5CQGrdLGwKBHtzQMLXnlRTM=; b=DLX8wO5GTNqJ47Br
	nEBmdJqQgE3moAcwb41VOVcbhue3W2xdx2BfcGzoIYFadITVz4ka9jJVJsIdvXp9
	A/I7FB7s12/C+KdM3Ifwo1XyZ6AAoEcGMH6m/ym/kpVgUV81Z0umi9Bb2qQGnmBX
	tvXc1dSihT6jpR4kKahSJnvbS/rRh9ahtlLrvrUiy1R2KgN3167IUgYNHjwSEikX
	/Xk0ABHHW/bNOMzI67uYNUPPcB47ICwA494HymRQsgNWVo1K7ZIZkp/d5vGRlGTJ
	KjqStsBJGvneQzsH8a4YBpIMCsi1f1IRzme/slyQtfYnUhN/0j8eW732sEIjfPq7
	1y9vpQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty3skjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 09:21:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749LZL4027311;
	Tue, 4 Aug 2026 09:21:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vjk7v0-1;
	Tue, 04 Aug 2026 09:21:35 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6749LY8M027285;
	Tue, 4 Aug 2026 09:21:35 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 6749LY9I027260;
	Tue, 04 Aug 2026 09:21:35 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 14:51:21 +0530
Subject: [PATCH v3 2/3] power: reset: pscrr: add watchdog pretimeout reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pscrr-reboot-reason-v3-2-e706dbfc7465@oss.qualcomm.com>
References: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
In-Reply-To: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfXyk1loyYXu/GV
 IEnxWPq3Ki9Y+fDbeLFvlIRI/Tk4LE+gRuatzna+dHI+6ogcmLRUeB/HxbaqJfHicDtprk8vR5v
 zYDML8o9ed3XvWnNxyQl6ICKylmEis0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX8RaEivsFOZzn
 VEFnudeoOdxc4hMLR0a6kC+MdzSjIkEz1kJmHklmTAieAQuEccrV0ffJvmH/zkFb0186Q0lE10I
 ePfDi3z9+CVxtZAEdFtysp4BIzRSFY91C9skRtCyD/hRaZD4r84R6SojCq6Ab6OuMEoQuA9msUZ
 ObTBgxEr8qxcUa0xTbMJMiljBskK24fZph1SgweWGHiQOxPNItvZ8cLyu4zmbicOvxbBnNDXqK2
 qB3HbX6enn8pSJ/o5U96L/wG4rvSIJq/KP8wM+zAtubJRA87U83OqCy0qSpUV9XXKRokmC2LjM+
 SslsHEv5tnpU7rZ3D2E6TkO9HOvnTmA5/F3jfCl4ll+LvN1gNo14FruxcE/WnssAI0YxSggEeEw
 cbIBkJl6/cIOVrfp3ClxQZDn/uCGXqaTKPWeKfElqKEtH5q/3oEXeg7pBi67xY6aslPtxmCE5A4
 LsMj/Do6hYXqTySCAhA==
X-Authority-Analysis: v=2.4 cv=Nu3htcdJ c=1 sm=1 tr=0 ts=6a71af23 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=liq4Q_DvyCEuhuVGVXgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H2MyqJYeTYjzehjanYoN70UroNY7K_I5
X-Proofpoint-GUID: H2MyqJYeTYjzehjanYoN70UroNY7K_I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040073

Watchdog pretimeout resets are not recorded with a dedicated reason,
causing subsequent boots to report PSCR_UNKNOWN and making it difficult
to distinguish them from other unexpected resets.

Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and prevent the
panic notifier from overwriting a watchdog pretimeout reason with
PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/pscrr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
index 8c45b84059a9..b7e6239e207e 100644
--- a/drivers/power/reset/pscrr/pscrr.c
+++ b/drivers/power/reset/pscrr/pscrr.c
@@ -529,12 +529,15 @@ static struct notifier_block pscrr_reboot_nb = {
 static int pscrr_panic_notifier(struct notifier_block *nb,
 				unsigned long action, void *unused)
 {
-	struct pscrr_provider_dir *dir;
 
-	set_psc_reason(PSCR_KERNEL_PANIC);
+	/*
+	 * Do not overwrite a watchdog pretimeout reason already set by the
+	 * pretimeout path before it triggered this panic.
+	 */
+	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
+		set_psc_reason(PSCR_KERNEL_PANIC);
 
-	list_for_each_entry(dir, &pscrr_dirs, node)
-		pscrr_do_record(dir, get_psc_reason());
+	pscrr_record_current();
 
 	return NOTIFY_DONE;
 }

-- 
2.34.1

