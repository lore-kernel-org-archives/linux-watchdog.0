Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1A49EC69;
	Thu, 15 Oct 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055355; cv=fail; b=Qvme3qtF2hshNMtmi8UO7aQxIHSQIp7fO2r89MnnGHorSncgu+uhAzXU5qb0JjpSjdyWWJuvIfAQY8X0JcI/jD+Q2OIeNifwkbWGOSRjDiE2zPk156fuqtVB6DE5aqCU70um5bD+gWlxZcb7nUeH6YZT24rkOf9wR+azM/ZHL3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055355; c=relaxed/simple;
	bh=Gw1UZ6EtSY/vw6+rd+VR/VjMbOcleSbsZZ2FBCDIy24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z28eUgFFg3SJeoAX4FzLDRtMMbeduE7uSvb41mFUMRbtpk9Fld2D0wrrShOzEuudF4uJLJvqmYHYoaGKfLtDOcYn8vDxpL7R7xfNX+snMD0XG69W42cuQKKBPTAvN9Wr/Z1SM6I+HYVyCShXdic5+uA+XLJEuypM4GtNvbIxWlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aFDS/VBQ; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aFDS/VBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrkyVb0s4knD5Sjkls6oa8gj5X8te5+71CPrepTZ8DzffswP73Lerht5wT/ygDMSDAoBmYASxMEJmE21yP6QZFvfp9TGHUt1aL+b/VnZD1JJCyySBvHPOCeA7tRszWmCpNBAI00xjLZSb/yJHihnQfkmnbcWyKIyK0sB5SGseyl6P0mkY3rWIj8MLW6CBu+ob1egqwPt0A+0eEyiMiUMY0k6O6+ax7KdBh3B0UhvIODl9+r20IPXD4jdMUrqIerdj7BH+xhWBPzcdbiRs/yNX+jSfLz72MxQ0FOgYHcJ69wkNFL1JSbJIJ4g4fqFc/5VBLZ9cHVWSLpylkFiXkJDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUNUX8l614Cu1T9gRDJe8kT9crA5BfHrMBGut1MO0uM=;
 b=kT+wQdrvz7AA2uz0jgz42fyAs3p3CUWi6bN2JIa/4ZFmZQO7RgVYCGrcOWR3mUtj11e9r9tAv/0llk83mr1WGcCX9C7FswzLXStY7FrDh56w1bBApWCrNv0I4SNKv2GcqQbRD3W6G2K+ywRE+GXZ2UnqDTvkLSlHKaoIlAMZPadCMhgIS7K69bswzHgC/OaxDtnyDvT872k0J7ngzO/5Y0E5BGBRJh8HQOjkWDYAfPBFYb/sywdodafkXlTrgq7XyOpqYHMSZdX6uvt25XO0vtLUwRvfRwVZkvGBzuwlqdi8aAqm8MPwXdiZoGoRqt4zzmVszXWuGLgJR8kiimqJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUNUX8l614Cu1T9gRDJe8kT9crA5BfHrMBGut1MO0uM=;
 b=aFDS/VBQrpd9Q4MS75f1GbHpAvxt+TvsQZsZu02hCrI8qjVn9exNNrYWMvJui1iLDJjYwV6qqk23qbm2MNauASCAL/9T40zYcyzTGMCtNaE2yeWirEc84uWKD89INFycAxKBmBcl0PEdDTh6CuMTgHXV9UMKvC81RmYGKaJRbD78PifFqmr+ALD3QuBC8Do/GWTkQSVxbV4sNK8845df3oivsOVBpSG278ZdTtPcd/5mnn14fAZtl4yjjCU6Ioqtk2kMGeKHmdajh1nyEHtbS3kuS/dIXZr5hG9QDBdaUIosutqbtEuw8DCdjcryi4dJMF7ZyDKMa05gcXdMkJWiGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:09:08 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 09:09:07 +0000
Date: Thu, 15 Oct 2026 17:13:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
	linux-watchdog@vger.kernel.org, upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: Re: [PATCH v2 0/4] da9062/da9061 watchdog timeout mode
Message-ID: <atCZR27iTkoDuxoG@shlinux89>
References: <20260924065044.368341-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924065044.368341-1-primoz.fiser@norik.com>
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 44643faf-4930-4e69-5ce6-08df2a9bf771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|7416014|376014|1800799024|6133799003|18002099003|18092099006|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eeszQ81CFVf4t+egsL3CWqwvlsgBZxLuTS5k4eBSiPDIPGFULBT2Hd1ul5GR10v/XY4cW5qfgqfLT1PyWkrMAblpJ+RO9r1c3HBb0zsJaNJ4LfaVvaOuMvvpzKRjl6rYHYTCwNgUDmbk4f1RHmauY82rCSawc2HKB4VBvTbyXkgmc25ssWbLX8dN2S2avQNQt3rzt1rBfXPsyXGL/mVz+ate/Ac8UVsluJUpqwNvXokrrQ57PiHNnoHvEVZgVRCHPE7Nh4NJ/kDKmRq0IwOJOGPJNLZFpO5x5ngNEFgNZCzKmCoNKuDtVie5HbpmTbIpqAbnlvtf3mk88U/jcgdS/oJbBNKzpkU+B/wihHgkzt5FxNylYHT7f9Ty1MXRw3vgxCxeyP35byObh+neyjlHKZPhbEzNQ2BObterCF3NE5OA0mTvlFdIdLKkyE5vB/Q2PEO1C2vOPpnOQ78iLcKbEsshDe70na/dFDMOsMC1+Y2GaqZTjrmh26j5nhQuFUVUtTyasyAe1mv+eR5NY4Jj3vAmC8kxoRXzD2yRAOz1tbnNBg+YtW/se6UPZ8VVvYOxxxYCKQ5PYw8OlLBAdpEn0y19dTvCFzlvWldKb7lXRUCtQ3PkhpdrzlE4k1CeK9JR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(18002099003)(18092099006)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/UxRbiGL3/3PtyNJWn2d0pgnMKR82GY1kNVU+T8osQDmlaJWz6lgcv6FT3W?=
 =?us-ascii?Q?O7Sbwsf13euAUktyqI18spc4uU+YmfjXN0d27OpFMes5MxMknbijkRE7YtQV?=
 =?us-ascii?Q?RJB5KU8JFxMXW9n2KYg2SC+Q6BB+BKbIdDwsIRUoagupBlt6+2keazEGpIUs?=
 =?us-ascii?Q?nThvPbe+dn9IhNysEn1WqYi9cZGksaqVgAQ9K8u/grpdEa9A6Yzhl6wDExUl?=
 =?us-ascii?Q?9rheuczrzRpOJgZQgvX88nlLJlBwZwf7Ec06ITYA87cPF3nunGZ5Irvgw1y4?=
 =?us-ascii?Q?JWWlA4zpE4QoauC+Lm5zlW+nC7k/kLIpKz4KirHn8JGZwJFPqbXSylyf8E4i?=
 =?us-ascii?Q?Yn0cVc8hdH1BhgIb+bd4K3b9IE6q7VYrxKv5pgLdL7hnlJneLA0LXSBv13K5?=
 =?us-ascii?Q?UxDKPbQhJiNjeYtqU8jgSDKUDDTy/f4boOa5YQeQDMD6if92V0EDlpCWuwbO?=
 =?us-ascii?Q?qB/0sM9Czm/pCq3dGinBSvbjzQYHPdRcHh86P5PInh05MOqWb7DHbTJt8B+u?=
 =?us-ascii?Q?GxQ3YrbBwMjTqQAU6Hi+VWr2cetXx9Q6GY6hWuYxuqSh3/sVfj5sYxSRH7ZK?=
 =?us-ascii?Q?doqRoEFEL4Sp7WCqcYQ3SAUsT5kBBD66q9odRsQ8o3L2FmuZMUgVKbsiE1kb?=
 =?us-ascii?Q?cNh5dnsbiEF34kWms8SMMtAX+KZU8sGvsXJTYjpzPzi4tJGHJBVkiwkcpJcA?=
 =?us-ascii?Q?jZrDsaPhwYoYoH0MsyRQvlL61GAMthLx7zBPtkTNJsdYZ9aSSBBNEmoLqRRV?=
 =?us-ascii?Q?TQJSBbktR/CrsUwq6jKMSfd/w+h4nWjks3KnF3fywHSM1Kqmtmg0E98sFgHl?=
 =?us-ascii?Q?9CCF+aM9jUHBXN8PzoOavZbnxF7goNr0x6wC8NZUCvJjQmU0Q23kYSX9fnU4?=
 =?us-ascii?Q?OKYvmkbSjhkb/yI1M6MxOKngXii7KhJ5rC9GPJeKXeFshWkmZqMnkObo54lA?=
 =?us-ascii?Q?kEw0/14FyuAn3zGI4EZvkhU1XMfOndceqJP6ZBix9mlUO5yqe+9dBdjGimxl?=
 =?us-ascii?Q?JV1BYi1W5mfCvYnhZhAZFobCoDYSGQ1SkN/Txq/44u8rXjx5ycrHVdCdOVdP?=
 =?us-ascii?Q?6S66G20fKOVg4LoqsxsgDL8vo6QdCVVTSTWDsu7zp6lx8Bi5awv22LuzX870?=
 =?us-ascii?Q?gk/dautlLMcTgrII3tCfwv4eQMFcttLV3zcIqj2KVdAgDXNj3jAsZSe25/uP?=
 =?us-ascii?Q?d6j24jfL0qjQEHF9idiOmeLAVAY8fBFYdk3FqA+uKCd0/k0acYdTVhCtx+jc?=
 =?us-ascii?Q?80d8BqSYE4q+HPvswcHfFkc1mtThaD1q8oyw3AFk0JlSfALmbLulJUVJS+Ei?=
 =?us-ascii?Q?O+4CIiJ4aCeJjNDOzdQEbyVMsn4tHvedord1tAu4FitjW1jfFLpOj2OXj2JF?=
 =?us-ascii?Q?1xc+MJjP4dXX/Cgc4qdbwH3O+qGbV0yumnk1yuubksTuHXwUgloGFZzQTa0y?=
 =?us-ascii?Q?sZwIGF959KGkbwJ/kMnCf1XgSARgmj/RISJ94OlsCFXS2MmWSI2kSl3MRTRX?=
 =?us-ascii?Q?82DgylQjwQlAoZCwOLoVfGYjsaanXIsyftZ58SYPTlCIpHw7R0zRfjSQdsI4?=
 =?us-ascii?Q?21+pkGO+xJ/7sWehrvfWanS9GDKJ6o6W0HNWMTd8LtmucAHOMqC3ftzmy/IC?=
 =?us-ascii?Q?BL9QlN+0cNnNmelgU2cl2nLvk2kWWaunkf6j0JX8Mc1RCy4KGq/a9q1mwFrX?=
 =?us-ascii?Q?hfCSk0qqlzqEg+LlT283gupmxyStmBrc3T+5Y3jdVcGnhZAHHYA27jCXj65J?=
 =?us-ascii?Q?sHFLPqaPAObclBeceppBVn0Z6KS4AlrGvTMgEpjxRC1p8978oMmY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44643faf-4930-4e69-5ce6-08df2a9bf771
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:09:07.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoeCrYii2J2PpE/tmXXIO8J+PWY3kYamKaqoTjbBJJwi+z/60Rr/KQlByEwg8FaVKA5QfXBMhKABI2+w5avZJVI5kQwiYRNjh1kym7pFzfWule4UhSTrt35XpHyceRcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217

On Thu, Sep 24, 2026 at 08:50:40AM +0200, Primoz Fiser wrote:
>This is a revival of a series originally posted by Andrej Picej in              
>December 2021 [1]. It lets the DA9061/2 PMIC watchdog be configured via         
>the "dlg,wdt-sd" DT property, to trigger a full SHUTDOWN instead of the         
>default POWERDOWN on watchdog timeout, and enables that on the PHYTEC           
>phyCORE-i.MX6 SOM.                                                              
>                                                                                
>From v5 of original series this resend drops patch 4/5 ("dt-bindings:           
>watchdog: da9062: add watchdog timeout mode") because it already landed         
>upstream as commit 382256b219fb, later converted from .txt to YAML by           
>bd888a4377ae. Thus dlg,da9062-watchdog.yaml already documents dlg,wdt-sd        
>property.                                                                       
>                                                                                
>Patches 1 and 2 (the mfd prerequisites making register CONFIG_I                 
>writable) needed a rebase: an unrelated commit has since added                  
>CONFIG_J, the register immediately adjacent to CONFIG_I, to the same            
>writeable-range tables. Rather than reapplying the original single-             
>register insert next to it, these merge CONFIG_I and CONFIG_J into one          
>range, matching the existing CONFIG_G-CONFIG_K style already used in            
>this file.                                                                      
>                                                                                
>Patch 3 (the watchdog driver support) still applies unmodified.                 
>                                                                                
>Patch 4 only needed its target path updated for the arch/arm/boot/dts           
>vendor sub-directory move (imx6qdl-phytec-phycore-som.dtsi is now under         
>nxp/imx/); its content is unchanged.
>
>Changes in v2:
>
>Patch 1 and 2: 
>- capitalize subject description
> 
>Patch 3:
>- implement Guenter's remarks (code refactor and update commit message)
>
>Patch 4:
>- capitalize subject description
>
>Link to v1: https://lore.kernel.org/all/20260923111719.2032012-1-primoz.fiser@norik.com/                                         
>                                                                                
>[1] https://lore.kernel.org/all/20211206064732.280375-1-andrej.picej@norik.com/
>
>Andrej Picej (3):
>  mfd: da9061: Make register CONFIG_I writable
>  watchdog: da9062: Add support for dlg,wdt-sd property
>  ARM: dts: imx6: phycore-som: Set watchdog timeout mode to shutdown
>
>Stefan Christ (1):
>  mfd: da9062: Make register CONFIG_I writable
>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
