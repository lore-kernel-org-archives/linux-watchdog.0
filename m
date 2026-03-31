Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121493E274D;
	Tue, 31 Mar 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961829; cv=fail; b=k1QTx3AGIDwTnPMCviNVuUFual0TjRujQ0CPczvLtw8CiYEgoFMTwq40EFrTJZKjp+kLnJrpxkhJxBDCvbiPCwJb69I5XWewrm6UKnq2p1YodcCNflAiLm33jKaIACTvuXg8PMY6we/2lQNojRsjCCKhPOFravNIcj/oD5ow1DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961829; c=relaxed/simple;
	bh=5CKD/N8ljmq+AS6GYe0clcmowjMnKA+yGWiTkWvPKzI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/RDPdJkrWG9/udPOVgxY5rv3tH+JPyc1Iv+7jMvwiobC1zrZSPUdF8gecbtnHmtcyZcgxeA14cKBTw3giiMOD8WT2wRwibAqxMD89oxpqQpGJyh2s+fPwYcEOtLYFVojs1maxlZb0kz0S8lKQr3KoQQBUQWnDMjDYKLuBXy/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uA0JNsL7; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uA0JNsL7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFvKaOwsn8dWVKvhF5MjUq8ILtAU6K9aIYNy58Ggjq2m9H8bqOwx6mw9IDj03Er8m3mqOkKtG5c7uebHFi+Lc9Snq0AYVccBjvAOYifjHxrA0TM/mjqA6FuP6Kc60app4agSVc1FNqx7olCI+JFy1a+8bHZKFH77SgPE1WbOqRT4SRZTRsR5w0dKMpa8jVcBWZjqWAj4C9UGnJjvr8Qy18grgJKFqjL4qgu5dWCCqQRBVy1esoDlVhSY843nTndr8V/6jnUuJGxy09uSUboSvvy99X524gSqUoKlHwtgvBclriX7nUGm6erN0ek/xPJVuxldcNe0gAKau3qgaEU2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CKD/N8ljmq+AS6GYe0clcmowjMnKA+yGWiTkWvPKzI=;
 b=Y0XldOiBFjxlEzunDrmY6JXYGXByKAV6HET5DaWUrBVY9tjBsP+JIDDU5isVY/y0PFpT3REKlJBZOoUyAleWV30o4KdGXB06EfzH2sWJOk+WpmzLQuXYe+SromOqT5acMsVedJgkgk2Z8T70dTV3UEgM1k36MEpXGcJV4Fw6gw0bY27PPe2C+n6ZMpRHOXENG0DlXh14M6Gb8GKKnS0v1q+1ZIFAnbHOIP/cc8pu3Nmj8850xvrNi1kHE6KdctUTB0fcWT0I3+avaWOoQPErsR1JwjO0vwDQyP6s4bpSrs7KncQAMJhQewbcrzs0nbNBExL4XnLKWj/WkHue17O7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CKD/N8ljmq+AS6GYe0clcmowjMnKA+yGWiTkWvPKzI=;
 b=uA0JNsL7Q3DBhIK8OXCi11a7ETViQUuibvFcd18ByzX1ykKGYroLYDdU5xWGhvlvXYyyrCB+MqEvrWGTqPQ3ftD3spUUo2UVJ50YMjGq+g56WKZfoOQuvbQyndqdteG5P/F6wz9mRA9+SemplIHU0UowLWnuQUaEDwWjWvb1k7ca3nUFEq03lqnsteidWTk6eM0dGKr+tUee9s7aUf0/J6JrYvaGA4puIg+drBQS7IX+o1TiGnLthPlXWVVy11HYVZ9cjHZ5C7IjVqArvomGgREytgqRWF/9vDs+cJPXw2TrVysOTIcmvZXeQywpRhgAl0CKoPTjnAvo3TS4/eK8Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by DB8PR04MB6922.eurprd04.prod.outlook.com (2603:10a6:10:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:57:03 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 12:57:03 +0000
Message-ID: <b665d94a-e82a-41df-8295-6379362404f1@oss.nxp.com>
Date: Tue, 31 Mar 2026 16:00:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: nxp: imx51-ts4800: Rename wdt node to
 watchdog
To: Eduard Bostina <egbostina@gmail.com>, daniel.baluta@nxp.com,
 simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260323175948.302441-1-egbostina@gmail.com>
 <20260323175948.302441-3-egbostina@gmail.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260323175948.302441-3-egbostina@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|DB8PR04MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c0af2a-db6c-49f4-5460-08de8f25010b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	h59v4FDqhUXRBz7x1++vDO1+029BLN018Rn1A47HjmIX5/5tkOkGb7Wi4ItzWW70qAlX84mH+tCwcOgRinAu8khrPjyjTOv1OX28DsmZPqjQOQDTpcHQUWIW6D7FKIWHsgjLypYmc5WwrCeOBNbiPuEFJQpj9F81nblv1KLF4PEfpYmd6kRvZdkBCKYxcKkldOqrllbl5RKWwKUFxsQROPhqTefIYObnEY/6w5MoisLY814oELcbGRrvdhJ6V/hso0H5ZqWHWjxDDrLlvwAEaTT1UUuAD6SQSAHy8K/9nH6+qyIQVfvzBrJWUmAP2fKuo2D6WVb6fzqSssd/zECTEetY/4OZZZO8CiMqqqoOLfiGf/1X+m9Ohvlt/wfFzclT6276VxaDGa2YszXJ0ZOAPBf9P0PdE/sJ41ij2VfsRGwJp0jwISro9vFUndxOduJjuWvR7DLGEa2rqa4klnVPBS9gwIla/mmADcthzKgLD467S76yFkcQjf/TNfM5xordgOn7RG4XqmLqdMYVE3QJHMAsmglGEtaLNwdjiLDYBqYIdZXni9CiuEwb/1X/5HtU+iObOiQz6liTtwcffpvX0nKIWsCGmiskbC20RGZ4MmFZbMXYxfzP5Gr722QOa4aF6ecZxXwa2RvWPGZJwZv1aK8jM0aMQVWQlgG7OWW8596NcFnmcFLbv2DtDWGA4VhDQPLA4lwoBcGLUa5N3DanOGdARQzFZYwMBLloa9sO8RdUDKWGj03xiP+JGSm994FUYFlzHiRH09vzT3Qy7a0oMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pERnpKSTRXM3pFY0czTWdOZzZudGxjZmRvYjVCL01aZStMdlVlUmNkMkJm?=
 =?utf-8?B?S1FqR2d5TktlVS9vU2ZVYm1MMTNRcCtma0hDbWJFcytEcExTUUk5TDJNckxT?=
 =?utf-8?B?dzJleXZWcVJwajlpTUxUOXNwbWVZajc5aGNXTmtLYy8xRzI2Y25ER1U2UmVs?=
 =?utf-8?B?Y3hEdEd4YTJwbHRha3pnVTgvU2V6TVZJcXNrdU93TVBKMXpBSTV4TkZtSlN2?=
 =?utf-8?B?NzVlUFhGblhZcFBxWXN0OXBUTzZYZks3MkVJa0g4VXcyb0tBNWtiRVNIbFZl?=
 =?utf-8?B?c3YyRFUzempNNERRcmpSTWdaMHIwbjFKeFgzWklmRzd0b1hQK1YreHdwU2h1?=
 =?utf-8?B?U2ZxTVd1WWx2K3NqNlVDUy82MFpvNTZTNE1YMTE3Mndjbm5KUDFxOVNpSnBT?=
 =?utf-8?B?ekh3OEF2WDhxanE1cHdvNUtaYnV1U2sxU2YzMkpPSzkwZ0VrSUVMc1dZNEpL?=
 =?utf-8?B?RThudFdHWUVkdUdnL0pVYm0wN05sUG05ZWl6YUs2ZjFEdjJkblQyUVp1UXov?=
 =?utf-8?B?ZnlXbVV1STNWc2l6c0lCMWNmdEJlUzhYVGE2RlRNQTFQbGJickJocVUyaFNi?=
 =?utf-8?B?NkE5bkFLYThJTnBRTVU4UHRzQXZzVTRvUUZXcWdVWmNPVmNLbU5ybWJ5T0FV?=
 =?utf-8?B?WU1rQnF6R3g1MUJoSWUyNng3QkNodFMzOUpCdGQ4eVZkbUh3RWRhSW5YNndL?=
 =?utf-8?B?TlZuWTBZTzIrcFJNUkRiMDk0TURvcFJybnkxWEpUb2pHNS9EeEFDWmgvK0Zt?=
 =?utf-8?B?cjdLTld0KzVsM2NZL0ovRnpvMXYyVWFIaVJxYU4yTTZQdDN3UTN4YnZIRVRl?=
 =?utf-8?B?QTZmMVBhaitBSEF1NGh4WDJmaWFzYnZXSjJPdmFYaDV0bEFXRG52aXZob2dq?=
 =?utf-8?B?c1NiaUtrZm1wOTI0QkFFR0o3UmZITDhzQmZtVHRZL2o3UGkwOUNOOUFFTkRH?=
 =?utf-8?B?Q0VvY1Jrc0tBSHhHYmxKUmdzekVkZU52Yk5DQi9QMlNoNEE2b0d4MFBpbHJL?=
 =?utf-8?B?ZWxLcVNWMjBxbmRYNTlyOVU0NHZ4dDBSS1hRM0RacFBPckFUZXdoeG1CSCs2?=
 =?utf-8?B?bDVKcUhiaGdWVFZ4aFMrOHQxUW9zWjlmU1dtZWZ1dXhyUFVzY1lCMm9IL2Uv?=
 =?utf-8?B?VHE2cEdWdFdNZzRJSWEwTVYxNTQyQ21jZ21rR1h2VU4wTWVTcUdWcVFvcDBl?=
 =?utf-8?B?NHY2OFI4K2dTUjZIMGVFL0NVWXFDR3IvUWs4WW9wS05ac21Vd1laWTVtSkov?=
 =?utf-8?B?dnpLMHExc3NMR2psK0pTamZESHFwQXlLaWdoY1ZuU2tySWRaT0VMYldVcTZt?=
 =?utf-8?B?dU1Na2JxL1YvWTBWbUdzVzljaThEaVZRaFlOZEJXcWVic3dnRjN0OGtCc2VP?=
 =?utf-8?B?enI5eWRPSTlWSVRWQ2VQS3lLRzhSbVRjWU16MEJoYXg2MGI5bGpxd0RKcndE?=
 =?utf-8?B?Z2gzSjNWQnpTa1JlNVFHV0x5QWtIcndmQWNZMzE5VWhVK3NmTFI2b28rM1A4?=
 =?utf-8?B?eEhCRFFXaEQyWnJXY1R3dTJJQ1hqNDNLWjJZa3pJMk4vRWtKeXltVllpcFNj?=
 =?utf-8?B?b3NGM3pFTE9kbHAweUpPZlNiQ0hoc1N4WE9XbVlwQzlERkdwQVN1Wjk0RzVp?=
 =?utf-8?B?TmVoVWcvQ3ZEZGtNMGtsR1pzdXVQN3pOUk5iQlZQb0U2U3BDTXFpTFpKWXZi?=
 =?utf-8?B?a25NNEpDMjlCRnBSSDNJSzlGOVBQOHUxd2dSaWRGYW1JdkpnZlJYTlhzUU9D?=
 =?utf-8?B?SkZjam9oTzd2QW9yeXVqTzJ0aTF5UFdxYTBrcDl2b3JYSW9YQnowU3FGcTc4?=
 =?utf-8?B?Wm5DL2Y2cEZ6d3VkYVQvbmpCbVZIcTdoVjNOR1U1RW5GMmtUcmVFNFNFaERN?=
 =?utf-8?B?cWlnMmlVZStmY0o3U2U4QlBOTVBKVXo5MjJHNWpsOXM1Q2VRTy8rM0lIbnM0?=
 =?utf-8?B?VWdhQVRpWGdUelJzVk1VcWQralgyVDNWQXpJMXI2UDdPU0ZIaXRMVS9NQm0v?=
 =?utf-8?B?V28rUlZPR2JQdTl4VGx0REcrTVNSeVU0Q1ZNU25NcXlpOFVxOHhZSzAveHdT?=
 =?utf-8?B?N2ZxLzNBS2dkQTJyVWVhOTQzeGJxRXRVLzV4WDhHRFhidE9NZENEQktTNXJs?=
 =?utf-8?B?NVVXdlZCWUdYNDAvd0xiaHdvZ1lTU3ZYTDJ5dXNEdjdvQkRGd1A3bFliNEJJ?=
 =?utf-8?B?MFpyN3Y1bmhFMHNhZHFOeUdQQmplcVZtOU56S0hLQlRxcklIWEF2NlVPcmNF?=
 =?utf-8?B?WVI0TXhvWnZpMERBaTJMWHZpSnhKZVkwbktnRnh0STBvajRWWXp0TjBRY2FS?=
 =?utf-8?B?ZHVmOVMwNmlJazdaeEd1Sks2YUl4U2RnN3MxRjNnRFA5dllqQ0FhQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c0af2a-db6c-49f4-5460-08de8f25010b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:57:02.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqE5bHSJPm1r/bz/CzFiemQmAKRnDErV5WEwdJHOFT6JjNNWsUr8sUDnAXKzLsYBR/YDMtoCxuQjux2nxxTmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6922

On 3/23/26 19:59, Eduard Bostina wrote:
> The Technologic Systems TS-4800 watchdog node was previously named 'wdt',
> which violates the core watchdog.yaml schema expecting generic node names.
>
> Rename the node to 'watchdog' to fix the following dtbs_check warning:
> 'wdt' does not match '^(pmic|timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
>
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>



