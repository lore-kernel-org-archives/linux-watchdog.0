Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4F39E9A3;
	Tue, 12 May 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594177; cv=fail; b=O8K8h+HifMT5NsEoSSIlfflc5rwsyHKIDPLEnDsL10tDVDEIcMkzjDyAfMBrpijWR/IkAZWlgc8KYt5/Sp42J2Z4ejvgMd7BQVXw03dz3Q1nlGHOVnKw+fzTQML3K+hF31ndo6ezjTwLp3+JeeBbkoNg7N4pY90VlnIlhjgjvCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594177; c=relaxed/simple;
	bh=HbrtQ7QnuLeqA5xGL6LQmKwMHFr6psIbu5R8b9zCg04=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MCoN+lBiZ6g8aaZoMDW8Jvbc6F0y/twO6/u7X/4bkMdSR1ph051eX+JWLaNAQcPHJZSQgsfMKv+woEaECDLt9/vR6cr9MwIO6HjBKu9XZ3snRJeA/Ua8k/+dICCWV5AGk3V88EhLVeZ6787nRAEQLwCmJbyFSVLR2uMTKSGq00M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ktxlqdIu; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ktxlqdIu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEbV6AszffSLJWCJKrY83rMvyjQs34e9EXhsXvKCVHIg0Z+eQ1jYiln1IJ4tRMi/TuKF1/7ZjhaKvIBXrPJee5fg7P4FVnUOG3oNAHepXdCkbYjyIx+lZlhiDMBGAg6zX7AZAI3csFO+634XctzOFc1bxqlSKDVTozM4XUmypr6O5iPds/nmJBK63GEddJFblZ/Neuzet1Af2jCrsmHMNiGjX7OIZJlIHilMpAJ4006MOYnqT1NGM37d8RmAWUy0M27oOvtc1snvTpC6/co4XEFJmPY1RRo2gYwNRRkr+8saA3c270Y/AT3oBRCfIEn8YIZG/+75smRpJbMP98NZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5nBu/S92YH6V2YHmKJL7F9DSMn2m9Nr59PnMQUOJH8=;
 b=kjn9RNR1XpgC5oT81aEcmV9FIHHDjWcTMRQWLcsiqotMbXSbuZwakBU6O+bQSlzb22U3KvYroTofLQSc6dE2+gGQYHxG55GPCEDq7b5CI0czBw7tpcjA+O+0xCvigwWI4PEMqlRrajRr+PcL9COUx1stUiBe0fIJn6eraxYOdzV4yue1aJabVoIS2K8PlguAxDgyrQ7zlfYmc0EC+NXMwXqQ4yDxb07z2T1NzHkqI/sO2H4MbXsLEAv+Iu6RZBYqStexwppyuS5LPTZ+yQ5eyeNkouA1177jaqRDU3EL09Y+M08n5RAXpQl8G76+HzWCM6ZndVCpeDnWOglpdhx5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5nBu/S92YH6V2YHmKJL7F9DSMn2m9Nr59PnMQUOJH8=;
 b=ktxlqdIuYO77nbAvxE1EbRNSGoAAxPGe48t6NlSC8P/C9Jng3Ufxtr2RdnpCzajqknhkcFNeu5wTnVBorBus4dUz3zcPgS+zbIm8ZOYlDsGD5RaIZAr46dEMiWudiIed1VQyTLHHbIiVhtdsnDzn1jdA/aPKdR3zYQ9Kum0UbzQeYBZwegik0ZcjAU80dhhkle/ZGVgW+XjqJTvoiSYfS/h5s+JEjH6MNVFruDzvrfGa7R2gs3Bf0OQ+lJtxZIms/h62XjKosvAUcpLmqVlz6cAECN7iyBUH0atCfNP5YR6tUrNw5hyre5aFBZc0MMPeE+y/v4sFarOBhKzawcwPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 13:56:08 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 13:56:08 +0000
Message-ID: <a53437c2-1f39-43e8-9d94-3f0867a557a9@nvidia.com>
Date: Tue, 12 May 2026 14:56:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for Kernel WDT
To: Kartik Rajput <kkartik@nvidia.com>, daniel.lezcano@kernel.org,
 tglx@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
 thierry.reding@kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260507154557.2082697-1-kkartik@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260507154557.2082697-1-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0497.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::16) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 486c9d51-4238-4bdf-1159-08deb02e37a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	47N5Jn/qDNrWmYa7AG4apdbTNneTATLsGbqwTHkbbLTYtMMvPdcZK3hus7DMKUOUXIL2kbjxG0CTSYDES5uUK7RnmRPTp2QDYSW73LHvO1szvE8+nL8X/il/4bZ4R0xOPOAhdQtQN3zhoAeY2gNwyi+OfGxgANT3roIBpintKxwdCXg7DC2qOd2Wa4Cyo5NQ7LR6Abs6y1y8IHcEypW5CdMwzYzQps9Z4W8AiA/qCwJQCoVkbvbPFqoN7D8E6jGVTHouQt2IOjoDEQkJHYelfPJ20DVXpa8842VBCpSG3D9h6IYtLEcwYo7yy0yzHK8uQA4FdJIE0MUB/s8bmp0A6IUgw0HdOFQLvC9zQFcoYseMUVYoLLSvmdOZ90Q+Df3Qu9heBvSHXNdMyCGQsNfB9HG0D+Tb119lGeVUsZND8PkUGKrqs9TldimkWeRbY0aPxvZ10e77pqfAolHKeNmMzQE3s2t92cH6yyCmybX6H3Gr1IlIX4yhMoqnVmG8qBvJNbOmQZgme/grvHDvt7hO62StOF2XBp1oRGudjvLLU+i6FZX2vs6rmAlEAwBgCGVXA51gonwLQ/cMxgXuskmdOoa/H/kyRB6o5dmTMBP5q7jRIT8wXpwhMHHiyOORa/xqpGGlvv6jctXg6Ygsmj4OOQQmiGVrDu3kOJpfaWMIoDrxAxFNHShQ0CgqnMz318xv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V25YQ3Q0T2NjNE9LcEtFN0I0Z1A1U2VwaTZwbVNVTU1MSXk1M1c0S2hVekk2?=
 =?utf-8?B?RG9sbjlNcnhVSXJHR3BkMTQ5N0V4cHNaU3p3T2h5MFV6d1o5V3VETzZkNm12?=
 =?utf-8?B?ZVhWdiszWWtzRjJFUlh4Q2kvWnozZmNOb1JFTWxqNS94U3VsVTJBeXdiVXJP?=
 =?utf-8?B?akU4UjlLcmZYZENiVTZhdjNORjVYampoQkhyQmhJeHZ4VkFJS2VuRzJYL0Iv?=
 =?utf-8?B?M2R6YlBQR3dOVjJMak1jVHQ2ZHFBb1hvMTI5YUxGQUhHUm1sR3ArdTlSZHAz?=
 =?utf-8?B?UHR1TEtncnUvZTRrbFBiSVAyc09seHl0WHNEQVR5S1JlbVhXVXN0TlVVc0Ey?=
 =?utf-8?B?TWlySG4zUVM1MG9vUEd1T05iNzJQVk0xUjBOQVJ5a0tVM1owL3MvK082Unpr?=
 =?utf-8?B?OEliMk12YTY4aHpjeURDdndDSnJTK0hvdEE2U2RIZVFuTnp6dUZuTHM4L29w?=
 =?utf-8?B?NzM4dWRGQlJPRWtDNXVabExXQThaZnVpQStwNm91QzFSZ3c1VGJFYzdUQ2dm?=
 =?utf-8?B?Y3pvS1lCOTdTMC9TZGJNc3MvaXlaZUY1YXNIRldlNnNOTDVldDRVbktoZXN0?=
 =?utf-8?B?WndDQUJVQ0h0dEJ2cjRRd0RFWEIrWW43UUVUTHBCQTBjamUyMkpXYWRmYzJC?=
 =?utf-8?B?YlNDRmdneVVaMS9XSTA1U3VSc05nTEh5cURjZitHUUY4ZG4zYzBpOGwrYzg2?=
 =?utf-8?B?aUZ2SmpMWk5zaEF6eGZhVWNFTUFzVW1hZnduOUpxQWx4WVZBWC9SM3g5dW0z?=
 =?utf-8?B?cmdFbW9lNFVMd0YyMjA5SkRSY3NnNng1d0ZIc1FTVFE3cmNoNE1ybGppcHh6?=
 =?utf-8?B?eFBxZ2F2Kzd5b1NyVllkS3Zwc1dHdE9GRmQrOE5TY3QxYmhsbGVET2E4cE1T?=
 =?utf-8?B?OHVBNlpXYjUwR28wdkYyWGhCTjNxdjlTRUI4TWlqWExaNEhoVnZsclBhazQv?=
 =?utf-8?B?NDZwckFiUGZCMVJNcjdORDl4c0gzdEYyYVRyaEl4YkNRV0x0MXhaeDdJUDJw?=
 =?utf-8?B?VlhxaDJ3TnpmOHc0ZndUOGtPOHROQ3MxTjV0MEpYOWY0ZE9iaWJsbVZ0Tzhh?=
 =?utf-8?B?bFB4WTZFdk0rUkx0UmRFMitFdnpGQWxPN0VDcnI1Q056ZWxBT2htR2FpOFBs?=
 =?utf-8?B?QTViNkh5enlGanJTb0dtbk13bzBvWFg2aDFFTkdkR09QK3VMQjRCNldEMUJx?=
 =?utf-8?B?QVRIN0dqcGFJMFg5NHZlaTNvcGNGQ1hFbStSbXpYZWkvaEpHemlWcHdBMm9n?=
 =?utf-8?B?a3ZBNURuMERoa0FZekJlQ0lvNlBjMUwyalNTQnNhc1VZK0FaWE1HTllBblRM?=
 =?utf-8?B?R0RaUm5oOERPT0ZLWitsRnNpS1ZPRmZHMk9oTE8wQVJNK0dGaWhGWHg0WWNl?=
 =?utf-8?B?ZVNlZ0tiTlZTVG9NcFRpWmZYaFVOaW95anR0Vm5SUGc0YVVRbEpKRkpobWpP?=
 =?utf-8?B?WjdFbnBVVEMrbnc0NG9VUXJlVVBhc3M0aEk3WWxkS0hzcVhBNWllenpRMjVU?=
 =?utf-8?B?UFZDOS9DWENuQjI4Tmw1Ky9jUjI4L0FHR3RvZUlieGQ5aTFZNXhiK0JBUnRL?=
 =?utf-8?B?bndPUzl6NU1nM3RnVS9Hb3RUVHpiSFphVXV4ZXR6dEVLQVVzZnBtNm9yTHJR?=
 =?utf-8?B?UzZvU2hiZ0s5QWpobmpyVVdOZzVCVDdRR2xoV0ptelJTQm0rbitXTVNWNW5G?=
 =?utf-8?B?Ujl1NFNUNjkwaXBWMkk0bXhuSjRPNFNFNE5VbzNkQUluTFpwbENMRDcxVXln?=
 =?utf-8?B?dUNjQWtGdk5OTlBnZy9QOWZxUjhVTVhyZUthZzcyeUQ1UjZHK21sQXkwb0ZC?=
 =?utf-8?B?enRIUXdHelp5cWF0R015K3Q5SmZKemttbEFFT0x3cXJ0QkRYOXhMU0xyNXBG?=
 =?utf-8?B?emNEaW51T1R4R21CNnZncHFQdkxPTnBkcWROa0dpU05DVjJFY3BsQzB5Q2Nh?=
 =?utf-8?B?RTJIc1crbmk3VHMyeVViQjA3dFpibnNPMXJ4VkFXRUZtRHovbi9yKzZCQlpz?=
 =?utf-8?B?SGpLekZSK2cvazV4aUtHS2d3bHBOS2o2dEQ3V1FEWGZqREtmNm9rMFNTMWU0?=
 =?utf-8?B?aHpoWmdXSGZBMjdNSlBXWlAyM3o0WElmQ1JpY1VUcjZXaE9ZRVBjVTdYTUxy?=
 =?utf-8?B?TjRMejR5LzBsMDgwREVsNDZ1MlpielV6U2VobDdVSzNYMnNWOTBhUGNsbnIv?=
 =?utf-8?B?akxIWDMzOWRkRklmYWJ0TmQyVDBkY2ZQN3NXNVV1Y3BHL2k3a2h1YUFaR2dk?=
 =?utf-8?B?aTRoUHF4dXI5dXpQNUQ2dVl3MmhtckUycXNlUFgrUE0rd3ZYUi80M1BuV0Rh?=
 =?utf-8?B?WEorL0llU1ZoZjFFVEFYWUo3ekJSTjdLVFBqMjF5UXU1bkdQaGRRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c9d51-4238-4bdf-1159-08deb02e37a7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:56:08.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPEiGT4/dF+i4ep+Zc6FZw9PSkN33cHcPKtnCUfJguDEsShQkt1vAs4NTL43dLC87G2l1vC5V0jxgdAn0Zb2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862


On 07/05/2026 16:45, Kartik Rajput wrote:
> Tegra186 and later SoCs support multiple watchdog timers in the TKE
> block, the driver so far only uses WDT0. This series extends it to
> make use of the additional instances and reserve the first available WDT
> for Kernel.
> 
> Patch 1 fixes a read-modify-write bug in tegra186_wdt_enable()
> that would otherwise make registering more than one watchdog unsafe.
> 
> Patch 2 corrects num_wdts for Tegra186 and Tegra234. WDT2 is connected
> to the Audio Processing Engine (APE) and cannot be accessed from Linux,
> so only WDT0 and WDT1 are available.
> 
> Patch 3 iterates over all WDTs and registers the ones whose TKE SCR
> firewall grants OS access.
> 
> Patch 4 reserves the first accessible watchdog as a kernel-only
> watchdog, arms it at probe with a 120 s timeout, and pets it from
> the driver's IRQ handler, it is not exposed to userspace, so the
> system can still reset if the kernel hangs before userspace opens a
> watchdog.
> 
> Kartik Rajput (4):
>    clocksource/drivers/timer-tegra186: Fix support for multiple watchdog
>      instances
>    clocksource/drivers/timer-tegra186: Correct num_wdts for Tegra186 and
>      Tegra234
>    clocksource/drivers/timer-tegra186: Register all accessible watchdog
>      timers
>    clocksource/drivers/timer-tegra186: Reserve and service a kernel
>      watchdog
> 
>   drivers/clocksource/timer-tegra186.c | 122 +++++++++++++++++++++++----
>   1 file changed, 104 insertions(+), 18 deletions(-)
> 

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

