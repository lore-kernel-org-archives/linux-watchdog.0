Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5693932DE;
	Thu,  4 Jun 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562990; cv=fail; b=Ci25W8vuqm+XjYnuIZBiydvW2oEUNUAzHDp8CK1nZEIPSNGjPD4HbUOe9dTdojKaLzMZejOEU0S7HBDKqLVCn11/QITlEPp3+5srbr7sYOWLmcnL8DiFe5MwWN1xROzgnRypB6AJMrSL+rxCnNPfwKZaeDuhT41GvtHo0ygkgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562990; c=relaxed/simple;
	bh=1uUwLMnHByBkEugBmFeblWo+NI2OlJmo8sa9IXU/A2o=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dn0RxO6b7H6MBiPvn89M4PVbpzLJlQ6ZeIebIYSYdPwtdwAP38C1IQAmO5a2ziBrOzgTvo8PCKTeLHvIhIYS7MbroKhtgExfT3ffSBgXsyipEFMP+Jh100C/MeztrypWV9HRaP7206rusOhANqjvdKTOgwNRI8YH/UEOe8VAIL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmD/et5u; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmD/et5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLOtCiZ7V1VBUGrMXNxDuqGJB/JJpJKQgWuABI4g7qRwVIGX1E7jkJoIMwjpR64K9Uxu+oHuzkwPhLnIYdeYntc5nvbfFV0Xc+8wKAUEkhKfm5X9M8wKM2EgRsZGB3lY2kuxnEGW7XZoe8R8Rbo+6e1qQxGAmL+e6Z8S8fhyE4k5qJ/WxYQ5uIPPFNpp9dY8LeWT7rX1NC1g0gfxU7XStei2efKc6seois5MDqbvun++NcJuudwtqEcNL6helL6otCsZg57o1mvaEruQ21W4jDL8+8twO7oOlALGv/8O4d9vKh4QQ7TaS3bZ0z1SzM7UvK6ip/D0CYxK9KD+iR+Psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEN0xV0ibC0UKj7rulv34/a3SyxNlXXZkzhOJJgqB48=;
 b=LoaGgM8qf4xdAstqCU3CT4KlG07SCtF1nj+cDDqwf+4EXB+Jn/N5gpefrxGcd+V0S7/EsqJDH8pCAF5yhM2UFRFim68iH1ie66ptHm4uw92b1yPXgujjAavV9J9kWAe1bmHO0nGjcxnIf3nfj+s2wmCqZiZMXw7n1grr5WKeQ26Kx7fclX0CVQfT1DesgfHyhvHWTMPnKiAMce2a3ufZguiEp3I/lX4qBqznWzJthTs1OALG0USOxaiKzM3xlK2UOIRySwNhQPGmilPRqPnvHY77zGE3sG3SxMzYfi7HTg4tkOsvWA2csGmrvtxkYb1ke5KIBOcKnRu08UeDyALR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEN0xV0ibC0UKj7rulv34/a3SyxNlXXZkzhOJJgqB48=;
 b=BmD/et5uXcxZhP9CgyeH3RV3EEuiDFuAo+3+pJSqfZBy4UXQxQFs950CzSKctFt1POjKQE18v37zZkoZNOeJ02gzXnlFauGwHkE5TKdbrcT4PQeJxlZYhLd+ExtVQu5JIyKvW2+CiJ53UPWH3+LTO4uK8BwPVACn7Yk59jFU/CsBZ5xBvqK+t96rrdwcM/SZQCEwpLOzOUo03v2sxLdgH7DIQnUH5bNoM7ShbnpeE4u1TpH4Y80HBWMvvGpV2N6I9aY8dLSglTCmd13mjpR5qtDDLFeJjAFRD8heka9lMNEV93Sa13bYYsWYT/0CNSn/FjVfjAiE712ko1ncOh8xiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:49:42 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 08:49:42 +0000
Message-ID: <b286735a-10e1-4446-8df3-9071e6e73de7@nvidia.com>
Date: Thu, 4 Jun 2026 09:49:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for Kernel WDT
From: Jon Hunter <jonathanh@nvidia.com>
To: Kartik Rajput <kkartik@nvidia.com>, daniel.lezcano@kernel.org,
 tglx@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
 thierry.reding@kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260507154557.2082697-1-kkartik@nvidia.com>
 <a53437c2-1f39-43e8-9d94-3f0867a557a9@nvidia.com>
Content-Language: en-US
In-Reply-To: <a53437c2-1f39-43e8-9d94-3f0867a557a9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: fc03b734-61f0-481b-3b26-08dec216383b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7jhVNA7CQxDinqk1h/HnJzez7FR31/HnMTS/odyq0dzaUPlGIIHNHFBVQR2l1haZnUiLONiZCHDqBJWcgftCjlMc8zrF4/wzjCVHBnk2SJlaTfUhyaICef3IgYsG4D0Ad/P/ghJU4R6I9RGqRAURTBOKh2vxd/x4Ow+Vi2GcP5o1YXzjk6SMgNcMRXAh6n/5fvVKzyKTiADneD1cW/VCYnxqUMMfYrS3tqB4wmS+4yqpLrxqjI4eCbep46ridBvqjAG2HC/b/SuNDFESDxs9/zE3xr5bNqbXBCMJdqLkSAHn61v0p/HTNios1XFIjJ4fkQvZe9xjE7iuKj+xerAd2TbFfeAK00023JI13xEttpqyAeUEOuFRpZmtWsfLzT+Pip2gHicN7pS0eQKyLLdcN8dpne1eInSHoAfLl56rstB48qOvv0WtWc/Y3wACnnsawWMYtAeo+IXpC42WXfT8ziuk1CHkVD4J1ZqZZ6wYKwAT1NKaVoWQs741dvBFt4XGvXt9VC9R9gXU3oX4T0WwPBTrj97XpG+JhnJklBZg5jqP1EorhAvQmrmnSx6T2lgDaWinZBINu3RWjQwSgT9rqZPBhp+nAaHyftaSBvsl4d/MWncCmTigFtThQXBJ7W0R+PAsg7V8Ot6rTA/IrcwVGquAa7Nr6Y+FX2Mafxbm9KMPvuYejym+M9/pPZQwpwfx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3V0Z1ZaMGQ4OTRtQkNhdS8reE5MeWdEblQ1SGUwVm94b1kvR0tiNVMvWERH?=
 =?utf-8?B?WHUvZGV0SDBVUENWc1pyNThRU0EvQVdOZk1CT0U3bVJERTVYT2IxR01ML0o4?=
 =?utf-8?B?dlJUemNHaDd1V3pmcFRCeWNJdm5VUlh3S3dGczJvQzlKdU1YRW51cHBIN1Ry?=
 =?utf-8?B?UllQbnFNQjNqVUdSY3pKNHQrcW1OSnVkMExGOXliR1krU1FRNktCaW80OTBl?=
 =?utf-8?B?TnVYdWlnbUZoTFJ6NlZlLzNJMVkybytMRCs3ait2M0NEOXRHTGQrM05SaHBK?=
 =?utf-8?B?L2kxdHZTdFJHUFNuU0lHcEl2bExHZG5welNwUllIQmZwUW1WL1B4YlVPQStC?=
 =?utf-8?B?MzZTc2VoWjlJd3dUQkN4LzhnOFpSVUduWkdRNUwyckVENnhEa3ZDMmc2N05n?=
 =?utf-8?B?VStQd0ZmNFlRK05TT0JCSHRRNDFVT2hQcGNQQ3dwMWhSeHZ3Wmd6OEp6UFlK?=
 =?utf-8?B?MkpwdSs3NTNxUFgyM2U2cDV2MnUwKzR5MjFpYjhtQkRrc01uS0swRnhiZjg3?=
 =?utf-8?B?aDQvK3FBSWpPM1BlUituQkRGVjFTdVhYcE9WckJsNEpERHhZQlJMaHJ0VUFS?=
 =?utf-8?B?UHZYM3pTUGVlUWpoaGptUjFsS0swWSsyWGZENndXMklPVTNLb0JTODc4VEJB?=
 =?utf-8?B?Zm8rTGtVZWVzNXh1TFlTUC9HTTVWQVRHd0tIUUVGZWgyQytDYnlnQmNVSWNV?=
 =?utf-8?B?RlVZcnZSSXNwVXZMb0U5ZmsvZzJVNHBCRkN3UVZOUTFUUmV2U0FURHpjRHdD?=
 =?utf-8?B?TDlQZ293Zm5tUEpXZ0FLdnc0ZkF3VkZ4VGpwRklwNGN0YXY1cFRtWlhKSzhK?=
 =?utf-8?B?amFadWpUWEFMYTlvRDNnd3ZrTWs0UjkySGV1Qkc5ODVMVTFWdnRkRjh5WS9a?=
 =?utf-8?B?M3FpQ0s2VFp3SVVuTndVYklNRm1Wa01SRmpOL280TG9wZmkxckRRZzh6K01j?=
 =?utf-8?B?Yi9EZUp6bWh3Zjg5d2VSajdYUEZkWHo5aHJGTCt1SlRPeHNCWlNLODArVWIy?=
 =?utf-8?B?aVVZb0dsam1UdGJaNUt6dHR4NWJmTlVsVlkzSTZaRmIyVFlkcmdBbjMra3d2?=
 =?utf-8?B?ei8xVHN5R1FMQzZPOU9VcmUwV1AzWG5zM1BCQnkrMXF3VXpmTFpTc1NEcmxD?=
 =?utf-8?B?YkNodWNuOHdINkVjSjR1OUo2TklDb2FKbnI2RGlkR1UvTVZxcVZYYzJuL0x6?=
 =?utf-8?B?WS9IM2RyWVhBVENCaFZRVHJrb2dvOUlmTUcyVE1jNjQ4Zm9wbnUvOXVWMDVs?=
 =?utf-8?B?cmN6czRpTmhFMUtUdXhKcmtBRGZTbTU5SVBwZjg5by9qY1loZjg0Z2gwY3h0?=
 =?utf-8?B?ckRtWDNPWGdSTzBJWlY0YzlVdFcycVJ1UVdDM1JEU01saHUxUXpHeGtheGE3?=
 =?utf-8?B?aEJaWkdyRngyWDFZUkQyUmo2M1ovTnQ2VEQxcWxOUDFDSmNBLzgyM1h5MFRG?=
 =?utf-8?B?WDhBL1VTNXdCeEdpVUQyOFNHeFRVU011UDlzUUkyMklKQ3lVQ1ZyWmh4cXN2?=
 =?utf-8?B?RXBCRjJSdGRaQmtmZ3RTNm45WkE1bXpQR2hKWUkxekMvcWtNNE8wQk95eTd6?=
 =?utf-8?B?UWJoUnA3UlZoZ25HQ0FPL1p1aUpTTjJsWmxSdFJvYXBvTWhaY0Qwcm1GbEgz?=
 =?utf-8?B?OWI3NFJiazR2MGl3RytpcGdOSFRFdDdRZjFrVUpZZjFxZEFmVHMzYWlRRVJF?=
 =?utf-8?B?WkNseU5HVlZYMHgwbE5vRk04ZGN0ZVZQc25vbVRsMHhYL1gyV2x6VVVZMFlv?=
 =?utf-8?B?RlY0d2JlRStLVGZFd0tqbHh2NnJvYTVHUTJFRVJTVk9yWUZmYW9YcXpXNGFT?=
 =?utf-8?B?eHVTS0hBeDRaNU5jaWU5WHJtN2JjTjIvOU5HMTNNZS9xOURLQjhCZHBtQW1j?=
 =?utf-8?B?eWd1NWdiYVNIWTdaNmtjV3V4MGtRQWdGWDZMOWZrdlF6ci83angrSVVoSVkv?=
 =?utf-8?B?UGJtRnlKU0lUNnI1MDcvQ2lueDI4Z0Flb2Rlczg1a010cGxFVjR3ZmNKNGV1?=
 =?utf-8?B?elBjajNGQTkwKzJSeDhuU2lHMldlc0wzd1BiZ1JrMmRXTy84TnE5eEJEdHBD?=
 =?utf-8?B?Ty9oOFZPdklaYTFHNThOc2R6MGV5SEFrRlpRVDFyMFRhR1JtY2Z3bTMxV3VQ?=
 =?utf-8?B?NWhZdHNCODNVWFpTTWJ6QXB3NlRERlBpbnU0WitnckdVcmwwTEc1SFRJTjlL?=
 =?utf-8?B?RktJdEZBOUFJMG9yaW0vaFlHSVRqU0ZVNHJUS05TRVRlY1dTdFRNS1ExSE1v?=
 =?utf-8?B?T2hDWVY2bis1cmx4azZIZ2RpamtkS3h3eE5DaVJ3djBTUjFWZ1hJMWhqNkVC?=
 =?utf-8?B?cEdJVDcvL0w3aGN5Vnh0VXM1ZE82TTZzOVFTVlZjSVA0ZzNrc2hYdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc03b734-61f0-481b-3b26-08dec216383b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:49:42.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM3+2PAwaCVATOUN1CbJjWNSCMNNG2K7ByZhBFh+aLDyJgiFho+aUyuvAixjf8o3+D/NyHd7plNoXea/OejYgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

Hi Daniel,

On 12/05/2026 14:56, Jon Hunter wrote:
> 
> On 07/05/2026 16:45, Kartik Rajput wrote:
>> Tegra186 and later SoCs support multiple watchdog timers in the TKE
>> block, the driver so far only uses WDT0. This series extends it to
>> make use of the additional instances and reserve the first available WDT
>> for Kernel.
>>
>> Patch 1 fixes a read-modify-write bug in tegra186_wdt_enable()
>> that would otherwise make registering more than one watchdog unsafe.
>>
>> Patch 2 corrects num_wdts for Tegra186 and Tegra234. WDT2 is connected
>> to the Audio Processing Engine (APE) and cannot be accessed from Linux,
>> so only WDT0 and WDT1 are available.
>>
>> Patch 3 iterates over all WDTs and registers the ones whose TKE SCR
>> firewall grants OS access.
>>
>> Patch 4 reserves the first accessible watchdog as a kernel-only
>> watchdog, arms it at probe with a 120 s timeout, and pets it from
>> the driver's IRQ handler, it is not exposed to userspace, so the
>> system can still reset if the kernel hangs before userspace opens a
>> watchdog.
>>
>> Kartik Rajput (4):
>>    clocksource/drivers/timer-tegra186: Fix support for multiple watchdog
>>      instances
>>    clocksource/drivers/timer-tegra186: Correct num_wdts for Tegra186 and
>>      Tegra234
>>    clocksource/drivers/timer-tegra186: Register all accessible watchdog
>>      timers
>>    clocksource/drivers/timer-tegra186: Reserve and service a kernel
>>      watchdog
>>
>>   drivers/clocksource/timer-tegra186.c | 122 +++++++++++++++++++++++----
>>   1 file changed, 104 insertions(+), 18 deletions(-)
>>
> 
> For the series ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>


Are you OK to pick this up? We would like to get this into -next if 
there are no objections.

Thanks
Jon

-- 
nvpublic

