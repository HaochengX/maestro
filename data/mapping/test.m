Constant SzM 100;
Constant SzN 100;
Constant SzK 100;
Network Test {
	Layer CONV1 {
		Type: Fused_QKV
		Dimensions { G: 64, K: SzK, M: SzM, N: SzN }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(100,100) K;
			Cluster(100, P);			
			TemporalMap(1,1) N;
			TemporalMap(1,1) K;
			SpatialMap(1,1) M;
		}
	}
}

// // BLAS 3 - Dense Matrix-Dense Matrix multiplication
// // Constants are in GEMM convention; (MxK matrix) x (KxN matrix) = (MxN matrix)
// Constant SzM 100;
// Constant SzN 100;
// Constant SzK 100;

// // Optimize for data reuse
// // Constant MTileSz 10;
// // Constant NTileSz 50;
// // Constant KTileSz 100;

// // Optimize for throughput
// Constant MTileSz 1;
// Constant NTileSz 1;
// Constant KTileSz 100;


// Network BLAS3 {
// 	Layer BLAS {
// 		Type: Fused_QKV
// 		Dimensions { K: SzK, M: SzM, N: SzN }
// 		Dataflow {
// 			TemporalMap(NTileSz,NTileSz) N; 
// 			SpatialMap(MTileSz,MTileSz) M;
// 			TemporalMap(KTileSz,KTileSz) K;
// 			Cluster(KTileSz, P);
// 			TemporalMap(NTileSz,NTileSz) N;			
// 			TemporalMap(MTileSz,MTileSz) M;
// 			SpatialMap(1,1) K;
// 		}
// 	}
// }