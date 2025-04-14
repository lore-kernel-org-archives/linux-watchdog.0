Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5827465F;
	Mon, 14 Apr 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642695; cv=none; b=MUMqSSLTki5urWcGXPTfTgr7v/g7hHpoOnVLUmxD1SbQr7bsNVDt3NHf7uhpWJgQ1qgeitou7g8KFxEGyQoAeiCQnXoEO6984jRuQCqtBnswWSlRM6fzqCz/MdQa1ZPkx+oc7vVK0XsAAq/SyIloM5zQDPMch943zmE2vay9zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642695; c=relaxed/simple;
	bh=PtjUEru/MWDigkFbMYqWhSeFikqKS2tSKC6Ni7r8tWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dreTT8dyjnqYnj/C9kEP7cdIXZ95e8VXWEDU4e42NcKLO2SNZPRC+ZbhMYIVk+IowVMpj/GkdCcZtObERegJ9s3Iu2I7t9QfLCAQniNcR4lE9nUG18iC4FRAYLkcQ7F7RJv+obQXUn9BKvmlwabLcOTQsQMy79E1uejOf0boJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=niK5s1o/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="niK5s1o/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 218954387A;
	Mon, 14 Apr 2025 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744642691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AdPveDqEJDa+CI3B6Nckox8CtUrK5elBYK6QnIu9Yw=;
	b=niK5s1o/Vf5WzfQCrvffcFGPBCfCo9nR+N7eROkfvrQiWTMqdcRHgSMPY1N7f8tj0ahDHN
	KPaNGKodMDj0xvSPnsdR/Nfbu+8JzRG4fOoMijFAtYxNOUW9zJbG6Wcy2iYSumM8gK6WuI
	QLWisGvrpA2ziGis/iDc53pIjKKaiWNdh/S64TF52w7P2+arKFD+892w1PwwxJoelCTIEs
	Qzdc7hD1NycsymrGFuebnWUlm8Trp5GWC1nAXsFAbYgr7UT+ybkZAUNRdfK41HJOsuUel8
	LhuXMUGRGcT7wpKpLkYCozUNckpSFTj7n6SmnMucNLJxNoTLqYBeRKlxNmQWQQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 14 Apr 2025 16:57:25 +0200
Subject: [PATCH v2 2/2] arm64: dts: imx8qm: add system controller watchdog
 support
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-imx8qm-watchdog-v2-2-449265a9da4e@bootlin.com>
References: <20250414-imx8qm-watchdog-v2-0-449265a9da4e@bootlin.com>
In-Reply-To: <20250414-imx8qm-watchdog-v2-0-449265a9da4e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepvfhhohhmrghsucftihgthhgrrhguuceothhhohhmrghsrdhrihgthhgrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeektdehvdeiteehtdelteffheduveelgeelvdetgedvueejgefhhfekgefgfeduveenucfkphepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpthhtoheprghishhhvghnghdrughonhhgsehngihprdgtohhmpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrs
 hdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdifrghttghhughoghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhmsehlihhnuhigqdifrghttghhughoghdrohhrgh
X-GND-Sasl: thomas.richard@bootlin.com

Add system controller watchdog support for i.MX8QM.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 6fa31bc9ece8..11527050ac8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -356,6 +356,11 @@ tsens: thermal-sensor {
 			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
 			#thermal-sensor-cells = <1>;
 		};
+
+		watchdog {
+			compatible = "fsl,imx8qm-sc-wdt", "fsl,imx-sc-wdt";
+			timeout-sec = <60>;
+		};
 	};
 
 	thermal-zones {

-- 
2.39.5

