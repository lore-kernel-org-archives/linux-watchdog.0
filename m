Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD554A2E20;
	Wed, 19 Aug 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160108; cv=none; b=J8bjpvS8CGUbCPBBnqlOqSI9XWYNFgg+3xn+r6FEQS9h3JmR+l3oD9JmPjHQL4B2CyHkth9vUmjzNWNCt++lZo0OXKON+8W27MK4usiHCN9I19PmXswObcbxUJk4/EztA60B/9Ys9SgUN/FZ2n1ujQqQynTklY+w4jm9sgjETmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160108; c=relaxed/simple;
	bh=NqJsIisW4ZWzUKnnepVXnP+dRrUOckssRKfcriXotLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2bOCd8QRgiVw35eII/dnRjfcjdDkQbpAihSGJPJ20K/jSDFsrPCo1uFwXUk4NA02bhblhWAjt6AZCpDHqQyTNbJ9hZKOgb212YTG2vK3YSOP8i8NuXHqxrRq2LzjV9cbsA6gMiFUo2r+rgGteaxHAHQXqgn2Hio5Fvq7TCST4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV1WVvFR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV1WVvFR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF1iLh537155;
	Wed, 19 Aug 2026 17:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFNW5D83mbINc3PMBmmkg1hwMrPPrHy8ooL+syO4Cqk=; b=oV1WVvFR9Rvul421
	XUGqdYVuQ0S0RKZmkhtzKcHQPcrygT3mJRN+V86fwyNSRqZu3sRUeCG+MOANyJ9K
	PS04R4WDT2VLgX8O5VqMeT0Br2hYUllAqVnr53KUVyscSVsqOtWuBhXZR4ZF1hEH
	NxV69mrUKSY5iFpxjfIxxNzB4zMougtbCfAVWzylH9j0xLa3z3QL6EHxpZxq4KWF
	8mrpkCjG76CUQvfPn1t2UVX6lsM9R+Zk+bxzsFCMiCRBN5cmseJNSqmLdOMV2Ahx
	VDGlXpMrbBlgebEQYqYUKTKjx4DdnamoX30FKCghmPojmF2eDF9m6m9DmeKcWXjx
	AlXcxA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es58rap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:21:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHL7Jt028021;
	Wed, 19 Aug 2026 17:21:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4g2h6kddah-1;
	Wed, 19 Aug 2026 17:21:07 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JHL5e8027937;
	Wed, 19 Aug 2026 17:21:07 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 67JHL5jD027916;
	Wed, 19 Aug 2026 17:21:07 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:50:45 +0530
Subject: [PATCH v2 3/4] nvmem: provide consumer access to cell size metrics
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pscrr-provider-v2-3-9072383e0f4d@oss.qualcomm.com>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
In-Reply-To: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: kVwZqaQhyhB6qQJGucHafrQfj3nZ2vXB
X-Proofpoint-GUID: kVwZqaQhyhB6qQJGucHafrQfj3nZ2vXB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX4/ZWPRjWvpyS
 NJZWDrkIhhILuk9WT1X6QcKSAMLqPCjYcUkUi5eXIC/Z5+i6U6WVt6fKX4jxgQBqp4lyDNKf3qP
 XN5YyEF3Aq4PaVoDZDEDRF2gwl+AsWY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX7aOWn+x9n1Fd
 28AuedgMBuFf4o5I50ScLybGkOM4xB93OmrZ0f0Zq9I5OUIqY1/k6b7336r0zNtGyKS3WFSRFKd
 l+OW6ulHIFdr4rvJNZCbbv0909sD8l13lleWiEJdZiIk2pR9hcIY5YIlfyHo85zA0nk9VS0SKM5
 yZGhH+dlIh9hHCW8rjvfCWzGBG+WBIXCszighxp/HGDfJ8mGNhORWUocet4ruK2ncsrzhfH3o4X
 behl0IPxxRlBiUOT+ZDObMEs63n6kFVQDZ1xLekUx+UmpjNVZGmF8YTH5FOOgMu921TeziQEbnN
 kByziPXGiNMcdBXOBJsO07uU+ozpNtGhB1pB1qa9XygQ/sQ6UA2NCyy2UOpavkF5tNTCU7QqqML
 KImwTHBDoP5f92jy4tgYbZZW7+NAcqsMrn4EqayCEIbi7ktRb7itwPfro0BC8dlGhzOcaHYzgtb
 PLNOjMZ43gQEe86yCvg==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a85e607 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=8iAkK7V-g8xI8jGQdaYA:9 a=QEXdDO2ut3YA:10
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190134

Add nvmem_cell_get_size() to let a consumer query a cell's size before
reading or writing it. Without this, a consumer that assumes a fixed
cell size can pass nvmem_cell_write() a buffer larger than the cell,
which fails with an incorrect-size error instead of succeeding with
the cell's actual capacity.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/lkml/dixmyhyj6b66vyizfotpqw6yzaavi2o2mauloa5x6zn3qgk5ub@huoal5ucdd44/
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/nvmem/core.c           | 29 +++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..49afcff4c72c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1790,6 +1790,35 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
+ * nvmem_cell_get_size() - Retrieve the storage size of an NVMEM cell.
+ * @cell: Pointer to the NVMEM cell structure.
+ * @bytes: Optional pointer to store the cell size in bytes (can be NULL).
+ * @bits: Optional pointer to store the cell size in bits (can be NULL).
+ *
+ * This function allows consumers to retrieve the size of a specific NVMEM
+ * cell before performing read/write operations. It is useful for validating
+ * buffer sizes to prevent mismatched writes.
+ *
+ * Return: 0 on success or negative on failure.
+ */
+int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *bits)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+
+	if (!entry->nvmem)
+		return -EINVAL;
+
+	if (bytes)
+		*bytes = entry->bytes;
+
+	if (bits)
+		*bits = entry->nbits;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_get_size);
+
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 				  void *val, size_t count)
 {
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..bcb0e17e415d 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes, size_t *bits);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
@@ -128,6 +129,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_get_size(struct nvmem_cell *cell, size_t *bytes,
+				      size_t *bits)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_cell_read_u8(struct device *dev,
 				     const char *cell_id, u8 *val)
 {

-- 
2.34.1

