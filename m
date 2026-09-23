Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA018497B8B;
	Wed, 23 Sep 2026 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162247; cv=none; b=BgHd39k5vJ5AD3fFcTPvFJaZzRXFk6DntgKfI/wkhmhhq7Dx78WFpodw/bIXo32q/x4J17k9oLOiH4PyEimtXUMwHOgpICZQKrHI19AsKPJuWSjE1e/i4IITDY4qdRiVngQbqvczvDOqtQzVI1FDObwniWLSbTnOz9cALi2HAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162247; c=relaxed/simple;
	bh=/erxChON3WP7deq/X7K8AzeokC3pi6fTT3B0Uqnh5sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhwTMuyMiaiGFPaQxbOwB88dtwSLSSyJKqXDc+XXzbo2+RoLnI+CaqDXO0KogFFiwj8EO0r+74WBoysgHnv7Bj/IHUsNT0c+w9SpkYniQRJuxQP6s9equsaSOlB/tHvBMXLEo6p2LjC0stcJlKUr0+BsAILEgqWN6x5m04iXIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=pVPC3yIQ; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="pVPC3yIQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u4gcMX4FNf2Q7XcN5np2SabpuUDCFFAb3KzYiZ8sO5I=; b=pVPC3yIQfap5XhRg7RdfeK2P1C
	P2y99b1Rmnhb3fCJiAiVMEjJn44TsNrvrZAYzOTeUsAeB1lRqL8D5ebZD2i8lAo8y3j/kGf23z4J/
	fH7powT7AesmqCsMNTvGapIj66Y6cefduLrTufJi44orQBRXqXrw0R1lEO1g+4iVtf7xZhueYRxcU
	5ymw0Tmz6+4/dlxEU/riSiyxVOlonMazdzXUSE1Nd8oR1UBiITJFFh/EjOPWg9u5QdGxH1tYKv8z8
	fNqhJlIIG7rio/5UcrMlwUIz2L71oVP8x4L1GOhcQqmKqt3l9SymcdLTcJrD79JjUA9nO+XOTga6F
	W0CT+WmQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:43182 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9KyZ-0000000A1qw-18ta;
	Wed, 23 Sep 2026 13:17:21 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-watchdog@vger.kernel.org,
	upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: [PATCH 0/4] da9062/da9061 watchdog timeout mode
Date: Wed, 23 Sep 2026 13:17:15 +0200
Message-Id: <20260923111719.2032012-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is a revival of a series originally posted by Andrej Picej in              
December 2021 [1]. It lets the DA9061/2 PMIC watchdog be configured via         
the "dlg,wdt-sd" DT property, to trigger a full SHUTDOWN instead of the         
default POWERDOWN on watchdog timeout, and enables that on the PHYTEC           
phyCORE-i.MX6 SOM.                                                              
                                                                                
From v5 of original series this resend drops patch 4/5 ("dt-bindings:           
watchdog: da9062: add watchdog timeout mode") because it already landed         
upstream as commit 382256b219fb, later converted from .txt to YAML by           
bd888a4377ae. Thus dlg,da9062-watchdog.yaml already documents dlg,wdt-sd        
property.                                                                       
                                                                                
Patches 1 and 2 (the mfd prerequisites making register CONFIG_I                 
writable) needed a rebase: an unrelated commit has since added                  
CONFIG_J, the register immediately adjacent to CONFIG_I, to the same            
writeable-range tables. Rather than reapplying the original single-             
register insert next to it, these merge CONFIG_I and CONFIG_J into one          
range, matching the existing CONFIG_G-CONFIG_K style already used in            
this file.                                                                      
                                                                                
Patch 3 (the watchdog driver support) still applies unmodified.                 
                                                                                
Patch 4 only needed its target path updated for the arch/arm/boot/dts           
vendor sub-directory move (imx6qdl-phytec-phycore-som.dtsi is now under         
nxp/imx/).                                            
                                                                                
[1] https://lore.kernel.org/all/20211206064732.280375-1-andrej.picej@norik.com/

Andrej Picej (3):
  mfd: da9061: make register CONFIG_I writable
  watchdog: da9062: reset board on watchdog timeout
  ARM: dts: imx6: phycore-som: set watchdog timeout mode to shutdown

Stefan Christ (1):
  mfd: da9062: make register CONFIG_I writable

 .../nxp/imx/imx6qdl-phytec-phycore-som.dtsi   |  1 +
 drivers/mfd/da9062-core.c                     |  4 +--
 drivers/watchdog/da9062_wdt.c                 | 27 +++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.34.1

