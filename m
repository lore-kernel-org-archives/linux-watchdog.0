Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8353BBFAE;
	Sat, 17 Oct 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255678; cv=none; b=JSWHkNmjzj4wIn/grI/YDZCVFZz1nuRmI+uPepokwL8v6VHqJuZpSOqycBHOPjQiu9YfhF46F4JoDjYNyzxf7gQgIWznWgjH6vr7j0Z1OFCZfc3BCIhd4GULylQ0lmjRgB7hfiiOIJbhqAKu0NyCY9e5qga9lmr1Wte1PCHTXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255678; c=relaxed/simple;
	bh=C4FRfj4wamUGn8rY0vb6qIc1L2oWaljYwkNRiCT3GGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGrYzoEpb0N3mz3xeqFLOVJb47sBz41xVqexeSZeN78KoEytlTygA9LhWU0UPJa74kf+OWBGwhFZtBrjygmcgK05vyoCwsYCJfREwYlzr8Iv12OlZRMm4YuYYiAWnvPXx9l/Mq2EQnhtCbAPcgGCaQNP5fOeKdiF6YMkDvdAdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQq5LRql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQq5LRql"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGAHhB2033071;
	Sat, 17 Oct 2026 16:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Cff2KPdGKOxo1XuIhdSBy5uzHdOGE4DC4Lf
	yDv2vqZY=; b=XQq5LRqlP6RJzJYBMRksAp9j60ZiRxJk+/KkB7MtXw12qKiPyc9
	D6AmXfJS6mkrT1lGUijqTD89S08FhXChR3uviDFno+w6rL9iN3ZGeRnr5KDjo4/g
	ZXJVI7WtFxlgYq4n0cotwD+gfHh2pN45g7+tQ9vtckFPxRvh8mjgxtfWlzIyGc/M
	08egtSyRgR+BiPxvO5AE+zwiE26jLHoEHslNC8bZ8M4BuWpqTiIUmW5vTBMio3Nv
	p6tMPHQ5X9LRCUA4ZNf0d60kn24doTOjKRmQmBPRYKI/D0fdcPDCUKOF5nImddSZ
	FSjnGBv6XeZwuUHehzaw7Qr5+qVMloaYOXw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxhcbn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 16:47:42 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGi6Cw1156800;
	Sat, 17 Oct 2026 16:44:06 GMT
Received: from hu-aalagars-hyd.qualcomm.com (hu-aalagars-hyd.qualcomm.com [10.147.242.11])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69HGi6uA1156788;
	Sat, 17 Oct 2026 16:44:06 +0000 (GMT)
From: Arunmani Alagarsamy <aalagars@qti.qualcomm.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arunmani Alagarsamy <aalagars@qti.qualcomm.com>
Subject: [PATCH 1/2] watchdog: davinci_wdt: Fix typo 'occured' -> 'occurred' in comment
Date: Sat, 17 Oct 2026 22:14:03 +0530
Message-ID: <20261017164403.2987788-1-aalagars@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfX7TFVISqbP/h3
 Bl+Y4ufC8Rde/aiqzxoBKoUaneYyor284fQyWFZPxYMs1Y82dT+7kH4gvq65o/9gOORUY51VSMI
 6/bKxkUZvspcq2lKN8Yb46pyq3sFakI=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad3a6af cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=vsytH-DHD1w-UOUJ09EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfXw+a7iGNzCxzM
 wayWA8qeMyfbpOxHuxU9IuucAYCxesEFRlflDDKEDoILMOKk5BM1pkwgVPjYk+eEAMTCdYABdOe
 X43hkJOjz4tJHS1q1ky0n/czeN3+T/hw1DnggyqtBpY6jC071jAb331eHaGND9oP5D5KSxqLvUh
 GN2gHygomjUoIGNliz3yuavP1QVa78Fy/Z0L43EC/ujRZJwU5Mn2nbmiIAHwlH1xZ/VZzEVSc74
 CIousN4GDTdb3YyG+oVdCAk1aR4S941sBQU6ndGtoRfwI6phR54aNFGZTt1G16PU+dfDDGhtPtm
 fGxYJoncNkVRMr562XpIbOB19/aHjnwSg8Kxy0GUKvb1RHQ60Ag9lNOqkuMla3hVtDzIByUeCIQ
 mtB2nF6eo1KnDHpjKIGjEmwT8aBZCb47dE7bH7GWOKXrsPjP3zxda5CIuP05q/ZDfPfJZ/czvkv
 otwtMObHcrT7Ohnxh4Q==
X-Proofpoint-ORIG-GUID: dCUZLmjrlC_9bJkYLsQQ6WAd1fDltftr
X-Proofpoint-GUID: dCUZLmjrlC_9bJkYLsQQ6WAd1fDltftr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170066

Fix a spelling mistake in a comment inside davinci_wdt_get_timeleft().
'occured' should be 'occurred'.

Signed-off-by: Arunmani Alagarsamy <aalagars@qti.qualcomm.com>
---
 drivers/watchdog/davinci_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 6ea0434f45c2..748dd24affb3 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -120,7 +120,7 @@ static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
 	u32 val;
 	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
 
-	/* if timeout has occured then return 0 */
+	/* if timeout has occurred then return 0 */
 	val = ioread32(davinci_wdt->base + WDTCR);
 	if (val & WDFLAG)
 		return 0;
-- 
2.43.0

