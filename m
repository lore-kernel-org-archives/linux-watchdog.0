Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21C3BE65F;
	Mon, 23 Mar 2026 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285193; cv=fail; b=OarJg3eGA/q08A0mXidoda94sgvFfWbOZmpI7yrVfKUXpQQeWUcXbgs+hTrZj47UQyLY0c9wsjAP4mQ3bmrIuY1ipKFmEO7vUFRdYtI8deEMp2s9sEsG+IKeNOKhME7Hbe/uOMk2ory1/b3JcCJD4mpAQuRb+U8pPcj6GP/objI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285193; c=relaxed/simple;
	bh=ghWoTCmNQAX2JcDVdLAOTGXl+Ja/H31zVUexIktglwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fNQsr1N0anTYmoRTsSskcXlzzo0llXwW1zTJFXxnydK4rKVri/tUWLXPqboUOn2G853+CScnyxA1U4dvmvqgd4zZJFMTr+mLvctsl7G3Uvk3FX/ZQ6RXVhKV+0TS6jDkJovbuz3rYv7QzlDvTmfJYlhqpvcjsIUzfr9S8pg9ZWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B8HImz1d; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B8HImz1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWBpXYNhuyc/7SxNKaazsGH2XhqwWQzatvS00V8WUErT3i2zfM1lnVEiBD5nWCXUv80IadHQBLKF+qBrJ0mY+cmJDXC8EWfcu870bZmqtPkmdInW4PqYUInN7WFEQnanMInjPLkM1M0W7FJX3iFbPDFkqBs1D/umwvxPZolzXoCjGPnAJoHy2XQFMhgsFTr7n6ri63c0fFZIBIe3tx6iTznOQp8hIQMe/MH2iu7Wl2LXmiNDZ1JNlZFLoUjso3y9AAS4Qbv5yUL7jbRUhWI7Z1+HnJp4QGT1e/5fGSbzKvrWOadCuNj3TWEL1raP5LEOS2ovx8qSiPhRqHaxE4q6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03hqnEAuspYj1fFMdrpO6ZDQqLsJ5+bFq/qY2mRtgQM=;
 b=N2s6F0+iDmQZABwswWvcf/7SADsfWVT7cinABKmkXi2sVmXiJF7behbCJKF6nEUwM6SJ3oiSw0u/c3VvXI8I91PrH5N+FW4zfAhLldLrq0NgFytdQeD1enlxl0yH7wSCxIpZ7gbfTFkaHr6IG4hESBGfnsyoaWMKkgpeA1FJ7f7HCQ+qVf9T2Ecls31D4qDcBdZZCc7yAnFLjar7HskiLm1DH4UNC8P0wU1S5dGU3TR4TW8/CyiLF0Q/Pv8ujAXSdYWDI30nPqBTWurvxgvJqm5zKpr0GEg1R9b1jxZVK2vyLYpGGv2p+pmrpogeH9gyJf9xcNmr1r8YpuQpucVCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03hqnEAuspYj1fFMdrpO6ZDQqLsJ5+bFq/qY2mRtgQM=;
 b=B8HImz1dEx1oBVYB1Se2O0dUY93qbXeeMr1p4LSO0RyzEBnPDBOY+fUPR6yAFj+ypveJ4XPh0OZsOtDp60uUbntseIxCXO9QAkZ0M/AtounuZZircxcaMba0k1No+LbGXAOU0m+zHk907UVYvU+uURfLJ04QILjLxztxx+sgLE6xf/Hr5SB5c01NibGCJ6PU7PmYSZErbzHvz5KdX2vxl9zc3pQqSDXyzB6/Vt6xPSr5kmvFT0Nxjsld+bTAFB3EDCzTKWnUxx/SqMdLq6GEag5lHLwlI21oLnInnz/b7szJwCQ7XdJN0RKKou8yizY5ep4Avo65ooqsLmNiz+vMBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 16:59:21 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:59:39 +0000
Date: Mon, 23 Mar 2026 12:59:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com,
	m-chawdhry@ti.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Convert TS-4800 to DT schema
Message-ID: <acFxdiHYjlSOESf_@lizhi-Precision-Tower-5810>
References: <20260323084616.10469-1-egbostina@gmail.com>
 <20260323084616.10469-2-egbostina@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323084616.10469-2-egbostina@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 1016c7f9-8879-4345-c0ac-08de88fd9210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GoejmQNfqswBXI/vbkBdmQSQmvoixD+J72nm1sn9fWELhH6n1BniTdqJ9Zk3xp2ElkfpGhLkAfY9eia5u0zy0obRF1y/b76QCqRN9iL95kDM69q49Qz7O3q9D4XMZvPDkAvkGqLfkQ2p+lyy3wLAdm/vkDQeoubH9ZQCdPUNxY0A/PK90CTWUq1f23HTjhaotJ+CLlX+/RzI8t4VNjO3vbaKOvuRPgumA3bpynDYtsQmB08VCqcmQ08aRzq5+Y+Ul9N6o6Z2gbXV7SpTcPmmvwAQqbmZSkOjnMD+TGI0TA64ijVv8shYy3JBzZgSW5KOs3qh+wrLRBeGk8CCAaNr2KF3AITmjZsNblFwPlSDdtC9AHQnMjGlU1Gw7YBvyN6eL0JGYK6CwICGOJyBHn7MExrwtFpHbzqtWLuxzz5raCZ+LPmB0weYejSNKeh8n6Mrt/RO5M07Tbmdxcs0256vybhB6dkO7tp5ZLKSA6OT9olBRcluFpBOxj6cLMINlwonzcwRwb46i54AA0927XPO+BnAZrbXAeL5zb3j1JwqVID9QJU1Y/dblkjexTdLYkG4wXKFokPolLw5xmngSpqQFjVa0Vikd+2xhlgNoA3Ldnzw+1ixzPLeIcElKZGGw2m9DHnaAA+lnWjHMofo11JvJ1OUj3ZPZFR+W1xqqVxErsGaygr5rfZWXb4XWCgf6ESbbxRFXJ3idT4Ozyp1haLZtuv38mFvlizhSifmFUMWcJeuMGzX+oDktOS6BTjyMoGE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r64wDRKdeMvYLJ2e+W/4FbB6Q9E6G0dLKi/ImozpnAXsTljfMQ+Gyp14JZpV?=
 =?us-ascii?Q?sTBYCMa/xX76A718lq7rU7dMB2NfDutYviQ6EIrHXq3OoJVV/AVe5Ev0Ywxm?=
 =?us-ascii?Q?4/cJmvXoLWQym/XjqRRql84tMSecgJzCG6aOIHl7zbHC26lU926VREVfFiyv?=
 =?us-ascii?Q?dLCDWYYuambciFvpYA1sdJkVO3FG9G0RxGkxVkY+P55DGGuJroxlqrjbNKsE?=
 =?us-ascii?Q?ODcQJnVqfa414yDAyGLvevodhJmNbu8a31Y42MtT7IMrj1jXdfr3msb4a3yy?=
 =?us-ascii?Q?fQBJOWcuQdrBQSwT3QQzLigZ+HCt008c/qvagsG1itQElYjSO4xiwu9UvNAo?=
 =?us-ascii?Q?Vz4CvKwMEByy35FfKcFvmDuet3R/ekFA+ZsFXuFtw/EDw77kmdzCH+qLXd0n?=
 =?us-ascii?Q?IYwSp2nmC8wsJj1y3gBvpCAXXrxE7jFaKtKdP/SQ7bo0/Gcb81nu88zcaQwr?=
 =?us-ascii?Q?qtpa0NmATyJ/7ps7HhtgelK02n2RffY+lK9tuBc4NFtsMrrObcTJP1TKOrAH?=
 =?us-ascii?Q?P+2CqxL0dWoL6BFNJEs4eDTs2F4BC/gDWfenBaQm18kEuzZVgOS5O0R/rpkx?=
 =?us-ascii?Q?FP+egoTQCtVHeHNhn4SciLtnAdFSEr+FJM+1hZO6bt4UfOSZ0Qm7QGfSuded?=
 =?us-ascii?Q?qhVEkzKXkQH4pm80oninSl2+e3to3EVbs/WwuiYfSxeKsSyt+aD3COWI+CPC?=
 =?us-ascii?Q?gY5+wmQU/xrVRDTyw2BVyKIzi7TD5s7PvydT1O4wHAH4EmpD6GDsCfYy5x6d?=
 =?us-ascii?Q?t1zlId8V0yzxvzHVa+PEA+DNkCxJSIKUbDGcKLYYfwNRNWEtDdqH8n2TAtFw?=
 =?us-ascii?Q?VxN56kgc88QNx4ZM0/U5iH/4l61U5HY3pLt3PKudMsNuMHUdkmrWyGV93ZXB?=
 =?us-ascii?Q?VVSDieZlD/hxkatRcE70W3sSJZNMp0/dP/Pm8utiU8BIHER290eIddqPRX0i?=
 =?us-ascii?Q?96tYRYqYn6JffhGetnhaj3C/UPcv8oANNgZGinl0ThUBflL1tbOBtLXHexCE?=
 =?us-ascii?Q?npR/jpBZCQLZfVvXHbPMO6oHTCAC32+bdS2zFZG11vcMgoGJdzyFmItdKsR0?=
 =?us-ascii?Q?X6jy+Q7RUyPR3WtH5tsZBISE0//+tXh1lHdiGs0D4aI1YVehKjSMrOXJU7E0?=
 =?us-ascii?Q?yAbey91r5Idqzr7AwwJ0rfdD1RYBozUutDkcY5QUZG1MJEWdgsryUkvc3nzB?=
 =?us-ascii?Q?VkJa7FosC4JTgyetXOi8qcL5RF4wgrE9WYME/YAXgFy+UU7A5WvMBC8++Dxl?=
 =?us-ascii?Q?2Vq6ozBQqaFET1+Cd/Ly40jySWHozc/YrsRLsmBozFQ/ADBcymibcGCUgNt1?=
 =?us-ascii?Q?fBg1T/NlAqiDJg0rd1lAE+77UsCq9KlznKHo3wILvBSrMLbrv/CmxR8NFBJa?=
 =?us-ascii?Q?ncQBD2Jna7AgWUaX3HQ44JVtx9ECdJUTOBEl86BVI2JEYKVn8D4Pf2/8PNqf?=
 =?us-ascii?Q?Id5r0Qiyyq6nkwAdZLrK3jKQdj4+hp6moGR04tzqe9rUe0EErp1bIdE8Gi6A?=
 =?us-ascii?Q?6pLC8Pc8p3cQYAbb7m7Ayy/v4e6GHUNP2vqFTxXN+OL0Y7yvBP/HYTbIwDwI?=
 =?us-ascii?Q?7sa3j8z00c4kOYXcnGFKKhILOBmwpc7pGCNhPob3GLE28lQeNZGk9J3Pa026?=
 =?us-ascii?Q?G2I7VuKNFr5fZTtfd4WsE5eetd/1Caz5ekOAg+tocfuU940sQByT7MX/ygzd?=
 =?us-ascii?Q?sPp4InfmjR664jbflqLvDcmN+0bVHdwjVctMTpkMaouiOtND?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1016c7f9-8879-4345-c0ac-08de88fd9210
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:59:39.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+9//NeFhNkRzxO1d3GOGawSAwlR4zN9y8po/VYqYP0jw7Yg1GhKNZbuucRHFkEjxKtYc+6mXHTwCGjOEU+BRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

On Mon, Mar 23, 2026 at 10:46:12AM +0200, Eduard Bostina wrote:
> Convert the Technologic Systems TS-4800 watchdog timer bindings
> to DT schema.
>
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
>
>  .../watchdog/technologic,ts4800-wdt.yaml      | 46 +++++++++++++++++++
>  .../bindings/watchdog/ts4800-wdt.txt          | 25 ----------
>  2 files changed, 46 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
> new file mode 100644
> index 000000000..cb2066b4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/technologic,ts4800-wdt.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/technologic,ts4800-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems TS-4800 Watchdog
> +
> +maintainers:
> +  - Eduard Bostina <egbostina@gmail.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#

Move allOf after required incase add if-else branch later.

> +
> +properties:
> +  compatible:
> +    const: technologic,ts4800-wdt
> +
> +  syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle to the FPGA's syscon
> +          - description: Offset to the watchdog register
> +    description: Phandle / integers array that points to the syscon node which
> +      describes the FPGA's syscon registers.
> +
> +required:
> +  - compatible
> +  - syscon
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    syscon: syscon@b0010000 {
> +      compatible = "syscon", "simple-mfd";
> +      reg = <0xb0010000 0x3d>;
> +      reg-io-width = <2>;
> +

Needn't this part. just keep below watchdog node should be enough.

Frank

> +      watchdog {
> +        compatible = "technologic,ts4800-wdt";
> +        syscon = <&syscon 0xe>;
> +        timeout-sec = <10>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> deleted file mode 100644
> index 8f6caad42..000000000
> --- a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Technologic Systems Watchdog
> -
> -Required properties:
> -- compatible: must be "technologic,ts4800-wdt"
> -- syscon: phandle / integer array that points to the syscon node which
> -          describes the FPGA's syscon registers.
> -          - phandle to FPGA's syscon
> -          - offset to the watchdog register
> -
> -Optional property:
> -- timeout-sec: contains the watchdog timeout in seconds.
> -
> -Example:
> -
> -syscon: syscon@b0010000 {
> -	compatible = "syscon", "simple-mfd";
> -	reg = <0xb0010000 0x3d>;
> -	reg-io-width = <2>;
> -
> -	wdt@e {
> -		compatible = "technologic,ts4800-wdt";
> -		syscon = <&syscon 0xe>;
> -		timeout-sec = <10>;
> -	};
> -}
> --
> 2.53.0
>
