Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12638F244
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654349; cv=none; b=fKsKJjmT9GA34mzhG4Cg8S7w7WV3/JVpBJHdoe4Upx+TF8BMPf/lwm1CsKkUYhsTw9v4cXDCwcerUha9oGBqs6MxlnJ9kjLAYPnKb+1s98JwnyK4+BIhUP6Mx088Q/hG4o+jUWsv+gyqe8gRFQv9EzjpQH2e02ZG+xXfS58VqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654349; c=relaxed/simple;
	bh=HYhh5175MjWDCW3hz6XHSycHBy64wcX8wW09sbGX2gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Alwy1kdtR4QU/P1ouOE+s7oI4hpKSRbSA/+stcNnY2mV+6gjdKFZkvKhnJ/Svw6wU+LfGYm8fzfQhqGHojjbDxyNkjxWKG3MH6dSyrBJNcdSjjL+sAC/rPny5G0pbADZDbYvnzpm3F7WWY+gZo815h4sEKknwLWvEkLglTmvwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlTloFLe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+HME7Xm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlTloFLe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+HME7Xm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64c6n662944
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=; b=nlTloFLeXHhd34SU
	KHEF07Cw4bHJjx4+NADFDDQK25xjWQN8q6A5ukg+f0T7kANvhLcVjo8x0IY8ksz4
	SkCe5/ki2c+E2Svz9nLH1uJukU3ByK5hgmJ4+3Cjfre8lRw42cgKEJ7pm27DfGBX
	0ApOLWMlmtnhE7pREydl4rEgsbNN4/Ci0Y8b+gsKIfEZZvtm6LFKC7x0YhEiLVGV
	eI4P/ujAeBoKSSTDnKxG64wWj0YMtVL/AkWKCaq6TeRjYk7quZeEw4TuOTcEnqCV
	lXQO3UIAmbcnj3bs+Mk7vwfZXtdv8Cehdq6lo8o3YY3x44uyPpAWyzTAVLuWl2Hq
	H+dyZg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043n2pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899eacb58a5so483896086d6.1
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654346; x=1774259146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=;
        b=E+HME7Xm1njdm35DvXN3ilADzesxZjPmFQR7K+o2QQRarRq/NTckc1QhHPAvvtkdN3
         GnidETFqgAkSyCfxm76nwFP/nE763UDyoTLBJzxXokCZBDXAu6K7e+5BMXJJN+7L6FcF
         mhj2xB0kA0RGDgK6CaaNqxccOtqE9TdRVHBjfFias0ZzbiNS+DtOUrEtvyz24KIfSr66
         Ki7IFIeYCSAqpsbOg/2+5FIAeeHVoglyZ/G7yUQF400+lAR7GNqUqgg8xA++gmckbxx/
         l1qWiycW9C5ToGx/k+2MTfUardVXvVTFBU+VEV89GFaXwRSONITnl+97zIgSNzkYHZv3
         dAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654346; x=1774259146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/me2wMiiolCP2vBwysex2L1/sOMs+/dHNx+CpVpgu5U=;
        b=bjHAqYPhsle/jXhO5PkUAqudU1JDDhb0+7/fNalTqu3ioMXUrbHcRTUTC8ZxC9NVo6
         biazXpZyjbVQEOj77z9xRjcK3bSx4/gcSBZOEv+6mcwt5IBN1Hme+vCP9mEsxPkZnTjz
         Q2djmYmM9ZCOJ0AFP8fpAjKfw/ag3KBYayLu0Gv6XUVa6Qy3REzR0vZhc45r1G68D47Y
         hh9AyrJG3YAB7j4KO6ioqN6VhEet6rHkI4axiQccowKYCYd+H4wczxK6feaafwB83Lu2
         oRN8Xc2+M8dKo+9mlnC4Dtk4F27UaKqb6t/msvr0ZBdqchMzyNZyVFM1mzf5FLvwb1Os
         zt5A==
X-Forwarded-Encrypted: i=1; AJvYcCUoX4tcM2g98wZjarJ6ITazl2iL/hDUpKZ+YBl201SBPUknbreRcZDcMv3twFZFk7Tr0Utl5Zmrh8qjX2Mnpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNvrVQK1L0qa061KFQIXM8D2rVaLJP4Nnjj0EZnroCvnctg5b
	T1GazCGJ/pkpRe+DFQ+V0ZPukABJtcUv1tN0s7FnSg3rXZmwxsMnTadbcQ5oiIyhlMXsL1otbuO
	7qyCq1FsEbGje80LauDBQvXT6lzQ8SW1tfVh2XtIFCLCEhkBtE2I8jtitX3zRX91LX8wabg==
X-Gm-Gg: ATEYQzwtc/jU6gNgBhBtLDMsB1XiTzZ8eolWlHDmqlC3nBoMsuLx0Jzm+UcXQ8UQniB
	JAnNgU7yKgzrmRjXB+i7mPxZTDcuok1ow6uHc39r0yq766oMhURvUjzqIub/Bj5khiCspq9AAJ+
	PXRRDWK1DlYzyehSl1UuLZxoUp7CtCdDcjn25Ax+zOY3T2+UqZDogNAqZac7LSXVvb/hYoqQlMB
	mfoAkb9pjbH4svRRKW41Xc6FGRl1Z9z5clPoZlAyw0FJP04XnSXpJTiDlQ5j/moufja5vKdcSGx
	DGjbZddD4KrYZfdQZcHmCi1KLzPx58HhBkTCv5B4f7m//ZhvpbBECSOzqt/D1KtNF/xWwq/KzGf
	g5u+xqZ6w7x7W/ebqTvsMqcS1/nVh+n5uqIhd1TCZPXSlVqHxlv6j
X-Received: by 2002:a05:620a:1a03:b0:8cd:8889:227 with SMTP id af79cd13be357-8cdb5bdf07cmr1592980285a.73.1773654346429;
        Mon, 16 Mar 2026 02:45:46 -0700 (PDT)
X-Received: by 2002:a05:620a:1a03:b0:8cd:8889:227 with SMTP id af79cd13be357-8cdb5bdf07cmr1592976685a.73.1773654345997;
        Mon, 16 Mar 2026 02:45:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:22 +0100
Subject: [PATCH v2 2/9] net: mdio: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-2-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HYhh5175MjWDCW3hz6XHSycHBy64wcX8wW09sbGX2gk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E6fJnMreFnmXzFZLhGkFMX3Zsbw1YGYTLK5
 r72IbihzNiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfROgAKCRAFnS7L/zaE
 w5VREACIACWA1TEOB3OkduZYg56RL8zQ+HZ6Oo/yVmrqQYlHjx25QRiQ2HPIcJJUzD/3LSnl5Az
 +CQjrdV2dnFfgYI0cfJ9o8p9YV1RGtqJcy+s0IbM01gIsppk09IuT1rSm4lrJc8uqe0aSp9ELSy
 UfT8wzgrIYj/AVf+j+w9WzR4VyzJony2Jd/gMvYeip/ndZ5lp+rdGjJmgO9rG95qPamh/V2up8w
 bJ8ucXvQHd7SoDqn3sl5sho1+xwrxd7XSSJsyDPIBazuuIi78vX4UD9m5Wf0Zk0ITqoC0btzxT2
 JrinwUMkNL42rcMRGtcE1M7j5sCO4D32hv2dx9/g6DRstSJhfFS0YuoAp9sJ7bAbhOYsMsgH3Hb
 iGrWSGNrsX3IFn0/Gon1aIDg0FpkjL9y4BjVz0FbY5A+SGZD1o5Nc5pcklxtWN4yEsRIxXw/7V9
 Pnjy7EKuWj1l9J/DgiYUZJn62N+H3hTVPzjnIIusYb5qsmQvhdCpEd7DLr4cc+Ph3zRmmvp7G+X
 uJIC32ILWINvVfp4ak7+VmGQRAuXyk1bE7WMCmskegYt1hmq9lMb+4LMUREytKZtMBNml+sXwiz
 P6ch0yS6NHRFKsXtzo0oGoJlAIns2XabXySwSwNCx2Xv+R0/UYkJxL9bt96Z7v6wiHsI0lTtHWS
 24r/N3M/aDxX2oQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfXwwp0CyYT2UIu
 C7omikBx+OzFmfXGw5Jr5bnC4HN8k97RGX+GE1URkEAbsQ78T/xqO1oqxWLNGFmP8CvHsNLV1uQ
 19pMDgAcXDCgtoAFM+faPxh9wAurhSCh2jYZLzCpebO6Aa7XDAQGmIypdqygC06XTDx0aJY0WIE
 aCLYuiEeMbJ15PL48zEbFq2bvfbHA87ae8AjTZZw7acchnmS11goVPHEi0ZmWKLYjmzPZ/MrgbK
 nmmqWgiSdMHQ0HD5xO5bM8orY4qhTVAKTacZe3P01F7cKUF9xXS3tfTRq5MWiGd7WjaQe0NPpnj
 BgFQplruhtpK9+fzaskBpzadPFKI6JOXS2a65iTjam3d4ULsaQ8NGpmeGE3Ii5hLx92gQtDN1YO
 wzoEu1LOUb6da4GPhuNHJlNaNnHZz29JI44y7bkxNDM/uRO/eD38dNiGO1oUhAuazHADWBkYFdl
 iPFUCDbpZ1gXNH6fO2w==
X-Proofpoint-GUID: FSb_w8XfszV3OQMDCMC5C7saekMRAWFp
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7d14b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=wUbH2sL_sFSbtn_y6v8A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: FSb_w8XfszV3OQMDCMC5C7saekMRAWFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/mdio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911b7d72e7289951fca90282d731913d..d7ca7fce7a3b86a435fac035534260146f114bc7 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -247,7 +247,7 @@ config MDIO_BUS_MUX_BCM_IPROC
 
 config MDIO_BUS_MUX_GPIO
 	tristate "GPIO controlled MDIO bus multiplexers"
-	depends on OF_GPIO && OF_MDIO
+	depends on OF_MDIO
 	select MDIO_BUS_MUX
 	help
 	  This module provides a driver for MDIO bus multiplexers that

-- 
2.47.3

