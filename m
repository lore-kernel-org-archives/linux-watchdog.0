Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NEH+lHY7"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCDBDB;
	Wed, 13 Dec 2023 13:54:08 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKph5E023132;
	Wed, 13 Dec 2023 21:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=93anGPWaV+nF7AivhePM52WtbZOAbrqQj80AlF5LYy4=;
 b=NEH+lHY7Ebr1W8yzUR3nmjXPe1HKjyU2appqJX8OCjKJBvln/ciLv+qd+jWIZzqsA/Iz
 /UtFGNLVWz/1jz5k1fNDUpm4fKuVkZuSM+he4rB1rXC1gvMr7YAaC11Yb+vWRdPxvCSq
 EtaSGE1sFESFShnKR/ir9tpLh1190vNRbyk+pt6LupsnM6A9huQNtAg7qZOm8Pk70PXa
 gp8rbMk4EUWMEo54TnovsnLLH9aNMQ2H4yb0ptkEWszvAoLRa7olzxxlF0lq/9rjkY4V
 FhGdMnkw2xC9sOC0rLiJD5NPk629qhdcIUOCSg1tCA0mhe+w7hP/yDJABayZIFJJeQjn Bw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3uydkrc49p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 21:53:53 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 77C2F132D2;
	Wed, 13 Dec 2023 21:53:52 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 0C51C8000B4;
	Wed, 13 Dec 2023 21:53:52 +0000 (UTC)
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/3] watchdog/hpwdt: Remove redundant test.
Date: Wed, 13 Dec 2023 14:53:39 -0700
Message-ID: <20231213215340.495734-3-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213215340.495734-1-jerry.hoemann@hpe.com>
References: <20231213215340.495734-1-jerry.hoemann@hpe.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GGyzWKnUGx6usK_7Br-VJ6XSeOKVPAte
X-Proofpoint-GUID: GGyzWKnUGx6usK_7Br-VJ6XSeOKVPAte
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=796 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130154

ProLiants of vintage to have an iLO 5, no longer send watchdog NMI
as an IO CHECK.  They are presented to hpwdt_pretimeout as NMI_UNKNOWN.
The preceding if statement rejects if !mynmi irrespective of value
of pretimeout making this if statement redundant.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 79ed1626d8ea..d5c0aa3ef069 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -181,9 +181,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
-	if (ilo5 && !pretimeout && !mynmi)
-		return NMI_DONE;
-
 	if (kdumptimeout < 0)
 		hpwdt_stop();
 	else if (kdumptimeout == 0)
-- 
2.41.0

