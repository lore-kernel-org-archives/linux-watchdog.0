Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1D403AE0;
	Thu, 24 Sep 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232652; cv=none; b=Sm7ypdDErfF8wxn1auNgydP1cxhlW+BjcRYc990svwqxihQeWg50yPd+aWa1ereoyUinga+NzjtsRFsCVyjVSJSoP8Rlgb81Z6Z3b9LuprWwxct5B44dF/wcZcxHd+UY9nBGlTLhnGPq5KFiHoVBH/O1IsT1fgNhyda8FKucUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232652; c=relaxed/simple;
	bh=j9r8nxSCTkvsmoiSxE6YtZBoJ5am0XO19M3F5XYzwck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxjM5a69ARSShZ0WUjg/OFBbxzLHp7LTbC2s5m+rw07HY/BcNrzljHXTdTWam7Csw8gEC47MJr13MxeyxQ+vfk4OKCSjR3W6fbYKJcEwluFs482JL3ITXUfL2UJGMlO4tuBHJEY/+Pyu7qIPZ7MBw/SiYlRtACIg/smhKSFaHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Dfru81rG; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Dfru81rG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pvbg/dxk+AXCSTE+uheu6nRjPFHJfcJOZt8KrB0ENwM=; b=Dfru81rGkINwCO7B3gaN4M5uo3
	YPXIChLRXufB1ejedu9Ey8Hs1FFFMo66uR7DMJjv7zcY9BCkvDa8+RVQhP8zBCJggH0+TiOp4cw9p
	9f6ldBzPmo5bw+CrGYDWebflmzupkpjnNNqWSHmDxdeGxNhZ6FWkv7QVr5xqJFs7GKFid1Fb7w2uS
	hnmAoFVaECVzrdN7R1duCNppMKN9RzfmSHY3bSdrtCyOIMZaDvbCXxb2vL4eCpudnxf3/5gGdSlf2
	c0mTgjMj9eubZoM8CRMGJSiuR1MeV+i+Td4ok3seYRZwSSQwV1YQP4HFNS4Zx1Blga0vUaYS5iPB5
	1UITnEGA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:54176 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <primoz.fiser@norik.com>)
	id 1x9dI7-0000000AyGs-1v6y;
	Thu, 24 Sep 2026 08:50:48 +0200
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
Subject: [PATCH v2 0/4] da9062/da9061 watchdog timeout mode
Date: Thu, 24 Sep 2026 08:50:40 +0200
Message-Id: <20260924065044.368341-1-primoz.fiser@norik.com>
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
nxp/imx/); its content is unchanged.

Changes in v2:

Patch 1 and 2: 
- capitalize subject description
 
Patch 3:
- implement Guenter's remarks (code refactor and update commit message)

Patch 4:
- capitalize subject description

Link to v1: https://lore.kernel.org/all/20260923111719.2032012-1-primoz.fiser@norik.com/                                         
                                                                                
[1] https://lore.kernel.org/all/20211206064732.280375-1-andrej.picej@norik.com/

Andrej Picej (3):
  mfd: da9061: Make register CONFIG_I writable
  watchdog: da9062: Add support for dlg,wdt-sd property
  ARM: dts: imx6: phycore-som: Set watchdog timeout mode to shutdown

Stefan Christ (1):
  mfd: da9062: Make register CONFIG_I writable

 .../nxp/imx/imx6qdl-phytec-phycore-som.dtsi    |  1 +
 drivers/mfd/da9062-core.c                      |  4 ++--
 drivers/watchdog/da9062_wdt.c                  | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.34.1

