Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6211489FAB;
	Thu, 15 Oct 2026 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054035; cv=none; b=Uf7m0q6X7PAH+O5LbXV9klR0PHdiet2dSbxwwhkOyR8XMC6+xIgG/D/FLbn0sEFal56FY6ertVghAeSoi50azLy8ROlD2J8g1q2jCoPzv+X2urEJm712OAmW2eJ+D9LbufiBk55KhR0B4XGMjl3ss0awr2jAtaKOf7CmoJBKsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054035; c=relaxed/simple;
	bh=F987hrawW6j3lj7eaAqLXa7a3paIzz8IWI/uyOLevBk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aCQa5TCgEqr/8S7IoCsGtVIj6SXmTQbc2fN5D7IOgsDFOilLxmvCmLFy2KvE9fT6kNF3/cfd87xGNtQ6ImpI+uJUPAZFtNrgXdoNmRpsY1woWlN+yN7ZPpyG0EthULrHMlPidnvlkydxVag1aV5Q6n3JqCvR2wX0agG6YsejjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=GSR3PJut; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b="GSR3PJut"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
	:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LbAfMirCzUKHKrH2TtQXopkikcdlOcqjFyzU/qMzrOU=; b=GSR3PJutykAc6yW3SjzxCY9G6C
	zh6votkzgnpbHj6UHP+0+TNf19NXZIOZE+cKqFdhWdP4cNptjwPm/Q0KaewBGsVMAnA0LZHDWuJiI
	OwQkGUPJzpeoC+RU+YQRVJGtX/n9tA+VnoQ2hItR1mzDtGUVbUb4izDUj7RUQNPTHjDBbr13JRwLt
	UANwA88lBGTbtl2/+SYANKvIiKL6vZCxgpT3wBbAfrkwFaIn/BZtTKHak9pfwfuzalntiZdMxrGtB
	AnxldgwamoSo7TQtWm/ukxiGorxjIBv2jFryPXagJ7dtFU8MyTJuq7lXbQ6zycCC80Np1jYTskicI
	h+8ixo5Q==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46922 helo=[192.168.69.116])
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <primoz.fiser@norik.com>)
	id 1xHH7B-00000002OC9-3Ybv;
	Thu, 15 Oct 2026 10:47:05 +0200
Message-ID: <ad97376a-8464-434c-b8c3-dffe395eef64@norik.com>
Date: Thu, 15 Oct 2026 10:47:03 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] da9062/da9061 watchdog timeout mode
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, linux-watchdog@vger.kernel.org,
 upstream@lists.phytec.de, andrej.picej@norik.com
References: <20260924065044.368341-1-primoz.fiser@norik.com>
Content-Language: en-US
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20260924065044.368341-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

gentle ping, can we get this applied soon?

Or is there still something to fix?

BR,
Primoz


On 9/24/26 08:50, Primoz Fiser wrote:
> This is a revival of a series originally posted by Andrej Picej in              
> December 2021 [1]. It lets the DA9061/2 PMIC watchdog be configured via         
> the "dlg,wdt-sd" DT property, to trigger a full SHUTDOWN instead of the         
> default POWERDOWN on watchdog timeout, and enables that on the PHYTEC           
> phyCORE-i.MX6 SOM.                                                              
>                                                                                 
> From v5 of original series this resend drops patch 4/5 ("dt-bindings:           
> watchdog: da9062: add watchdog timeout mode") because it already landed         
> upstream as commit 382256b219fb, later converted from .txt to YAML by           
> bd888a4377ae. Thus dlg,da9062-watchdog.yaml already documents dlg,wdt-sd        
> property.                                                                       
>                                                                                 
> Patches 1 and 2 (the mfd prerequisites making register CONFIG_I                 
> writable) needed a rebase: an unrelated commit has since added                  
> CONFIG_J, the register immediately adjacent to CONFIG_I, to the same            
> writeable-range tables. Rather than reapplying the original single-             
> register insert next to it, these merge CONFIG_I and CONFIG_J into one          
> range, matching the existing CONFIG_G-CONFIG_K style already used in            
> this file.                                                                      
>                                                                                 
> Patch 3 (the watchdog driver support) still applies unmodified.                 
>                                                                                 
> Patch 4 only needed its target path updated for the arch/arm/boot/dts           
> vendor sub-directory move (imx6qdl-phytec-phycore-som.dtsi is now under         
> nxp/imx/); its content is unchanged.
> 
> Changes in v2:
> 
> Patch 1 and 2: 
> - capitalize subject description
>  
> Patch 3:
> - implement Guenter's remarks (code refactor and update commit message)
> 
> Patch 4:
> - capitalize subject description
> 
> Link to v1: https://lore.kernel.org/all/20260923111719.2032012-1-primoz.fiser@norik.com/                                         
>                                                                                 
> [1] https://lore.kernel.org/all/20211206064732.280375-1-andrej.picej@norik.com/
> 
> Andrej Picej (3):
>   mfd: da9061: Make register CONFIG_I writable
>   watchdog: da9062: Add support for dlg,wdt-sd property
>   ARM: dts: imx6: phycore-som: Set watchdog timeout mode to shutdown
> 
> Stefan Christ (1):
>   mfd: da9062: Make register CONFIG_I writable
> 
>  .../nxp/imx/imx6qdl-phytec-phycore-som.dtsi    |  1 +
>  drivers/mfd/da9062-core.c                      |  4 ++--
>  drivers/watchdog/da9062_wdt.c                  | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com

